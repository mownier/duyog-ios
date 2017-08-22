//
//  AVPlayerServiceProtocol.swift
//  Duyog
//
//  Created by Mounir Ybanez on 14/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import AVFoundation

protocol AVPlayerServiceProtocol: class {

    var delegate: AVPlayerServiceDelegate? { set get }
    var volume: Float { set get }
    var duration: Double { get }
    var isPlaying: Bool { get }
    
    func prepareToPlay(_ pathURL: String) -> AVPlayerServiceStatus
    func play() -> AVPlayerServiceStatus
    func pause() -> AVPlayerServiceStatus
    func playAt(_ seconds: Double) -> AVPlayerServiceStatus
}

protocol AVPlayerServiceDelegate: class {
    
    func onEnd()
    func onPlaying(_ progress: Double, duration: Double)
}

enum AVPlayerServiceStatus {

    case ok
    case invalidPathURL
    case noPlayableItem
    case playTimeOutOfRange
}

class AVPlayerService: AVPlayerServiceProtocol {
    
    weak var delegate: AVPlayerServiceDelegate?
    
    var periodicTimeObserver: Any!
    var endTimeObserver: Any!
    
    var notifCenter: NotificationCenter
    var player: AVPlayer
    
    var isPlaying: Bool {
        return player.rate != 0 && player.error == nil
    }
    
    var duration: Double {
        return player.currentItem?.duration.seconds ?? 0
    }
    
    var volume: Float {
        set {
            player.volume = newValue
        }
        get {
            return player.volume
        }
    }
    
    init(player: AVPlayer = AVPlayer(), notifCenter: NotificationCenter = .default) {
        self.player = player
        self.notifCenter = notifCenter
        
        endTimeObserver = notifCenter.addObserver(
            forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil,
            queue: nil) { [unowned self] _ in
                self.player.removeTimeObserver(self.periodicTimeObserver)
                self.player.replaceCurrentItem(with: nil)
                self.delegate?.onEnd()
        }
    }
    
    deinit {
        notifCenter.removeObserver(endTimeObserver)
        player.removeTimeObserver(periodicTimeObserver)
    }
    
    func prepareToPlay(_ pathURL: String) -> AVPlayerServiceStatus {
        guard let url = URL(string: pathURL) else { return .invalidPathURL }
        
        periodicTimeObserver = player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 100),
            queue: nil) { [weak self] time in
                guard self != nil && self!.player.currentItem != nil, !self!.player.currentItem!.duration.seconds.isNaN else { return }
                
                let progress = time.seconds / self!.player.currentItem!.duration.seconds
                self!.delegate?.onPlaying(progress, duration: self!.player.currentItem!.duration.seconds)
        }
        
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
        
        return .ok
    }
    
    func play() -> AVPlayerServiceStatus {
        guard player.currentItem != nil else { return .noPlayableItem }
        
        player.play()
        return .ok
    }
    
    func pause() -> AVPlayerServiceStatus {
        guard player.currentItem != nil else { return .noPlayableItem }
        
        player.pause()
        return .ok
    }
    
    func playAt(_ seconds: Double) -> AVPlayerServiceStatus {
        guard player.currentItem != nil else { return .noPlayableItem }
        guard seconds <= player.currentItem!.duration.seconds else { return .playTimeOutOfRange }
        
        player.seek(to: CMTime(seconds: seconds, preferredTimescale: 100))
        return .ok
    }
}


