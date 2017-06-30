//
//  MusicPlayerViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController {

    var navigationTitleLabel: UILabel!
    var songTitleLabel: UILabel!
    var songArtistLabel: UILabel!
    var collectionView: UICollectionView!
    var trackView: MusicPlayerTrackView!
    var control: MusicPlayerControl!
    
    var item: MusicPlayerViewItem = MusicPlayerViewDisplayItem() {
        didSet {
            guard isViewLoaded else { return }
            
            configure(item)
        }
    }
    
    var controlState: MusicPlayerControlState = .pause {
        didSet {
            guard isViewLoaded else { return }
            
            control.configure(controlState)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        view.backgroundColor = theme.color.black
        
        trackView = MusicPlayerTrackView()
        control = MusicPlayerControl()
        control.delegate = self
        
        view.addSubview(trackView)
        view.addSubview(control)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
        configure(item)
        
        perform(#selector(self.performTrackViewSample), with: nil, afterDelay: 3)
    }

    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        if let nav = navigationController {
            rect.size.height = nav.navigationBar.frame.height
            navigationTitleLabel?.frame = rect
        }
        
        rect.origin.x = 20
        rect.size.width = view.frame.width - rect.origin.x * 2
        rect.size.height = 80
        rect.origin.y = view.frame.height - rect.height - 32
        control.frame = rect
        
        rect.size.height = 36
        rect.origin.y = control.frame.origin.y - rect.height
        trackView.frame = rect
        
        control.configure(controlState)
    }
    
    var timer: Timer!
    
    func performTrackViewSample() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            guard self.trackView.slider.value < 1 else {
                timer.invalidate()
                return
            }
            
            let newValue = self.trackView.slider.value + 0.01
            self.trackView.configure(elapsedText: "0:00", progress: newValue)
        }
        timer.fire()
    }
    
    func setupNavigationItem() {
        guard navigationController != nil else { return }
        
        var theme = UITheme()
        let attributedText = NSAttributedString(
            string: "PLAYER",
            attributes: [
                NSKernAttributeName: 2,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        navigationTitleLabel = UILabel()
        navigationTitleLabel?.textAlignment = .center
        navigationTitleLabel?.attributedText = attributedText
        navigationItem.titleView = navigationTitleLabel
        
        let barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_down"), style: .plain, target: self, action: #selector(self.didTapBack))
        navigationItem.leftBarButtonItem = barItem
    }
    
    func didTapBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func embedInNavigationController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.tintColor = UIColor.white
        return nav
    }
    
    func present(from parent: UIViewController) {
        let nav = embedInNavigationController()
        parent.present(nav, animated: true, completion: nil)
    }
}

extension MusicPlayerViewController: MusicPlayerControlDelegate {
    
    func musicPlayerControlWillConfigureSounds() {
        
    }
    
    func musicPlayerControlWillShuffle() {
        
    }
    
    func musicPlayerControlWillPlayNext() {
        
    }
    
    func musicPlayerControlWillPlayCurrent() {
        switch controlState {
        case .play: controlState = .pause
        case .pause: controlState = .play
        }
    }
    
    func musicPlayerControlWillPlayPrevious() {
        
    }
}
