//
//  HomeViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 28/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, FlowControllable, HomeViewControllerProtocol {
    
    var flowController: FlowControllerProtocol!
    var interactor: HomeInteractorInputProtocol!
    weak var moduleOutput: HomeModuleOutputProtocol?
    
    var navigationTitleLabel: UILabel?
    var header: HomeHeader!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var contentItems: [HomeContentViewItem] = []
    
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        view.backgroundColor = theme.color.black
        
        header = HomeHeader()
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset.top = 228
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        
        view.addSubview(header)
        view.addSubview(collectionView)
        
        HomeCell.register(in: collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
        var item = HomeContentViewDisplayItem()
        var cellItem = HomeContentCellDisplayItem()
        
        item.headerTitleText = "POPULAR ARTISTS"
        
        cellItem.titleText = "Beyonce"
        cellItem.subtitleText = "195 Songs"
        item.cellItems.append(cellItem)
        
        cellItem.titleText = "Eminem"
        cellItem.subtitleText = "296 Songs"
        item.cellItems.append(cellItem)
        
        cellItem.titleText = "Lady Gaga"
        cellItem.subtitleText = "98 Songs"
        item.cellItems.append(cellItem)
        
        cellItem.titleText = "Britney Spears"
        cellItem.subtitleText = "237 Songs"
        item.cellItems.append(cellItem)
        
        contentItems.append(item)
        contentItems.append(item)
        contentItems.append(item)
        contentItems.append(item)
    }
    
    func setupNavigationItem() {
        guard navigationController != nil else { return }
        
        var theme = UITheme()
        let attributedText = NSAttributedString(
            string: "HOME",
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
        
        var barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_menu"), style: .plain, target: self, action: #selector(self.didTapMenu))
        navigationItem.leftBarButtonItem = barItem
        
        barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_search"), style: .plain, target: self, action: #selector(self.didTapSearch))
        navigationItem.rightBarButtonItem = barItem
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        if let nav = navigationController {
            rect.size.height = nav.navigationBar.frame.height
            navigationTitleLabel?.frame = rect
        }
        
        rect.origin = .zero
        rect.size.width = view.frame.width
        rect.size.height = 208
        header.frame = rect
        
        rect.size.height = view.frame.height
        collectionView.frame = rect
        
        flowLayout.itemSize.width = rect.width
        flowLayout.itemSize.height = 188
        collectionView.reloadData()
    }
    
    func didTapMenu() {
        
    }
    
    func didTapSearch() {
        let artist = Artist(
            id: "artist1",
            name: "Coldplay",
            bio: "Coldpay is a British rock band formed in 1996 by lead vocalist and keyboardist Chris Martin",
            genre: "ALTERNATIVE ROCK"
        )
        let album = Album(
            id: "album1",
            photoURL: "",
            name: "A Head Full of Dreams",
            year: 2015
        )
        var song = Song(
            id: "song1",
            title: "A Head Full of Dreams",
            genre: artist.genre,
            duration: 223,
            streamURL: "http://127.0.0.1:9003/v1/file/song/b6d6qk92d7s0nv0i27pg/audio/b6d7kkh2d7s0t9hcg0v0.mp3?access_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYjZkNm82MTJkN3MwbnVxYmZqNmciLCJjbGllbnRfaWQiOiJiNmQ2bmZwMmQ3czBvOGZ2MWw0ZyIsImV4cCI6MTUwMzg5NzI5MSwiaWF0IjoxNTAzMjkyNDkxfQ.Ftn_T2rTnQeJ5KC9A21KiNCZhQsq9Atbju_SORRxq5s"
        )
        var songData = Song.Data(
            song: song,
            artists: [artist],
            albums: [album]
        )
        var songs = [songData]
        
        song.id = "song2"
        song.title = "A Whisper"
        songData.song = song
        songs.append(songData)
        
        song.id = "song3"
        song.title = "Amsterdam"
        songData.song = song
        songs.append(songData)
        
        song.id = "song3"
        song.title = "Always In My Head"
        songData.song = song
        songs.append(songData)
        
        song.id = "song3"
        song.title = "Careful Where You Go"
        songData.song = song
        songs.append(songData)
        
        let artistData = Artist.Data(artist: artist, songs: songs)
        
        flowController.showSongList(.push(self, true), type: .artist(artistData))
    }

    func embedInNavigationController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.tintColor = UIColor.white
        return nav
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeCell.dequeue(from: collectionView, at: indexPath)
        let item = contentItems[indexPath.row]
        cell.content.item = item
        return cell
    }
}

extension HomeViewController: HomePresenterOutputProtocol {
    
    func displayData() {
        
    }
}
