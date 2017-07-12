//
//  MusicPlayerViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 30/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController, MusicPlayerViewControllerProtocol, FlowControllable {

    var flowController: FlowControllerProtocol!
    var interactor: MusicPlayerInteractorInputProtocol!
    var moduleOutput: MusicPlayerModuleOutputProtocol?
    
    var navigationTitleLabel: UILabel!
    var songTitleLabel: UILabel!
    var artistLabel: UILabel!
    var collectionView: UICollectionView!
    var trackView: MusicPlayerTrackView!
    var control: MusicPlayerControl!
    var photoPageController: PhotoPageController!
    
    var items: [Song.Display.Item] = [] {
        didSet {
            guard isViewLoaded, items.count > 0 else { return }
            
            configure(items[0])
        }
    }
    
    var controlState: MusicPlayerControlState = .pause {
        didSet {
            guard isViewLoaded, controlState != oldValue else { return }
            
            control.configure(controlState)
        }
    }
    
    var currentItemIndex: Int = -1 {
        didSet {
            guard currentItemIndex != oldValue, currentItemIndex >= 0, currentItemIndex < items.count else { return }
            
            configure(items[currentItemIndex])
            photoPageController.collectionView.scrollToItem(at: IndexPath(item: currentItemIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        view.backgroundColor = theme.color.black
        
        trackView = MusicPlayerTrackView()
        control = MusicPlayerControl()
        control.delegate = self
        
        photoPageController = PhotoPageController()
        photoPageController.dataSource = self
        photoPageController.delegate = self
        
        songTitleLabel = UILabel()
        songTitleLabel.textColor = .white
        songTitleLabel.textAlignment = .center
        songTitleLabel.numberOfLines = 3
        songTitleLabel.font = theme.font.medium(17)
        
        artistLabel = UILabel()
        artistLabel.textColor = theme.color.gray
        artistLabel.textAlignment = .center
        artistLabel.numberOfLines = 3
        artistLabel.font = theme.font.regular(13)
        
        view.addSubview(trackView)
        view.addSubview(control)
        view.addSubview(songTitleLabel)
        view.addSubview(artistLabel)
        view.addSubview(photoPageController.view)
        
        addChildViewController(photoPageController)
        photoPageController.didMove(toParentViewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
        interactor.load()
    }

    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        if let nav = navigationController {
            rect.size.height = nav.navigationBar.frame.height
            navigationTitleLabel?.frame = rect
        }
        
        rect.origin.x = 20
        rect.size.width = view.frame.width - rect.origin.x * 2
        rect.size.height = 120
        rect.origin.y = view.frame.height - rect.height - 16
        control.frame = rect
        
        rect.size.height = 36
        rect.origin.y = control.frame.origin.y - rect.height
        trackView.frame = rect
        
        rect.size.width = view.frame.width
        rect.size.height = rect.width * 0.6
        rect.origin.x = 0
        rect.origin.y = 108
        photoPageController.view.frame = rect
        
        let height = trackView.frame.origin.y - photoPageController.view.frame.maxY
        
        rect.origin.x = control.frame.origin.x
        rect.size.width = control.frame.width
        
        let songTitleHeight = songTitleLabel.sizeThatFits(rect.size).height
        let artistHeight = artistLabel.sizeThatFits(rect.size).height
        let songTitleBottomMargin: CGFloat = 4
        let totalHeight = songTitleHeight + songTitleBottomMargin + artistHeight
        
        rect.origin.y = (height - totalHeight) / 2 + photoPageController.view.frame.maxY
        rect.size.height = songTitleHeight
        songTitleLabel.frame = rect
        
        rect.origin.y = rect.maxY + songTitleBottomMargin
        rect.size.height = artistHeight
        artistLabel.frame = rect
        
        control.configure(controlState)
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
        flowController.exit(true)
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
    
    func musicPlayerControlWillShuffle() {
        interactor.toggleShuffle()
    }
    
    func musicPlayerControlWillRepeat() {
        interactor.toggleRepeat()
    }
    
    func musicPlayerControlWillPlayNext() {
        interactor.playNext()
    }
    
    func musicPlayerControlWillPlayPrevious() {
        interactor.playPrevious()
    }
    
    func musicPlayerControlWillPlayCurrent() {
        interactor.togglePlay()
    }
}

extension MusicPlayerViewController: PhotoPageControllerDataSource {
    
    func photoPageControllerPhotoCount(_ controller: PhotoPageController) -> Int {
        return items.count
    }
    
    func photoPageController(_ controller: PhotoPageController, assetFor index: Int) -> PhotoPageAsset {
        return .remote(items[index].albums.count > 0 ? items[index].albums[0].photoURLPath : "")
    }
}

extension MusicPlayerViewController: PhotoPageControllerDelegate {
    
    func photoPageController(_ controller: PhotoPageController, configure imageView: UIImageView) {
        var theme = UITheme()
        imageView.backgroundColor = theme.color.gray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
    }
    
    func photoPageController(_ controller: PhotoPageController, didChoose index: Int) {
        interactor.playSong(index)
    }
}

extension MusicPlayerViewController: MusicPlayerPresenterOutputProtocol {
    
    func prepareDisplayOnPlay(_ index: Int) {
        guard index >= 0 && index < items.count else { return }
        
        currentItemIndex = index
        controlState = .play
    }
    
    func displayOnPlay(_ progress: Double, elapsedText: String) {
        trackView.configure(elapsedText: elapsedText, progress: Float(progress))
        controlState = .play
    }
    
    func displayOnPause(_ progress: Double, elapsedText: String) {
        trackView.configure(elapsedText: elapsedText, progress: Float(progress))
        controlState = .pause
    }
    
    func displayOnRepeat(_ enabled: Bool) {
        var theme = UITheme()
        control.repeatButton.tintColor = enabled ? theme.color.pink : theme.color.gray
    }
    
    func displayOnShuffle(_ enabled: Bool) {
        var theme = UITheme()
        control.shuffleButton.tintColor = enabled ? theme.color.pink : theme.color.gray
    }
    
    func displaySongs(_ songs: [Song.Display.Item]) {
        items = songs
    }
}
