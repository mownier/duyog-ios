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
    var artistLabel: UILabel!
    var collectionView: UICollectionView!
    var trackView: MusicPlayerTrackView!
    var control: MusicPlayerControl!
    var photoPageController: PhotoPageController!
    
    var items: [MusicPlayerViewItem] = [] {
        didSet {
            guard isViewLoaded, items.count > 0 else { return }
            
            configure(items[0])
        }
    }
    
    var controlState: MusicPlayerControlState = .pause {
        didSet {
            guard isViewLoaded else { return }
            
            control.configure(controlState)
        }
    }
    
    var currentItemIndex: Int = -1 {
        didSet {
            guard currentItemIndex != oldValue, currentItemIndex >= 0, currentItemIndex < items.count else { return }
            
            let item = items[currentItemIndex]
            configure(item)
            controlState = .pause
            trackView.configure(item.trackItem)
            photoPageController.collectionView.scrollToItem(at: IndexPath(item: currentItemIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    var isRepeated: Bool = false {
        didSet {
            var theme = UITheme()
            control.repeatButton.tintColor = isRepeated ? theme.color.pink : theme.color.gray
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
        
        if items.count > 0 { currentItemIndex = 0 }
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
    
    func musicPlayerControlWillRepeat() {
        isRepeated = !isRepeated
    }
    
    func musicPlayerControlWillPlayNext() {
        guard items.count > 0 else { return }
        
        let nextIndex = currentItemIndex + 1
        if nextIndex < items.count {
            currentItemIndex = nextIndex
        
        } else if isRepeated {
            currentItemIndex = 0
        }
    }
    
    func musicPlayerControlWillPlayPrevious() {
        guard items.count > 0 else { return }
        
        let prevIndex = currentItemIndex - 1
        if prevIndex >= 0 {
            currentItemIndex = prevIndex
        
        } else if isRepeated {
            currentItemIndex = 0
        }
    }
    
    func musicPlayerControlWillPlayCurrent() {
        switch controlState {
        case .play:
            controlState = .pause
            
        case .pause:
            controlState = .play
        }
    }
}

extension MusicPlayerViewController: PhotoPageControllerDataSource {
    
    func photoPageControllerPhotoCount(_ controller: PhotoPageController) -> Int {
        return items.count
    }
    
    func photoPageController(_ controller: PhotoPageController, assetFor index: Int) -> PhotoPageAsset {
        return .remote(items[0].photoURLPath)
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
        currentItemIndex = index
    }
}
