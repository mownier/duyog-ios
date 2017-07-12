//
//  SongListViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController, SongListViewControllerProtocol, FlowControllable {

    var flowController: FlowControllerProtocol!
    var interactor: SongListInteractorInputProtocol!
    weak var moduleOutput: SongListModuleOutputProtocol?
    
    var navigationTitleLabel: UILabel?
    
    var header: SongListHeader!
    var tableView: UITableView!
    var prototype: SongListCell!
    var playButton: UIButton!
    
    var item: SongListViewItem! {
        didSet {
            guard isViewLoaded, item != nil else { return }
            
            configure(item)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        view.backgroundColor = theme.color.black
        
        header = SongListHeader()
        
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = header
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        prototype = SongListCell()
        
        playButton = GradientButton()
        playButton.tintColor = .white
        playButton.gradientLayer.colors = [theme.color.pink.cgColor, theme.color.violet.cgColor]
        playButton.gradientLayer.gradient = GradientPoint.topRightBottomLeft.draw()
        playButton.addTarget(self, action: #selector(self.didTapPlayButton), for: .touchUpInside)
        playButton.setImage(#imageLiteral(resourceName: "icon_line_play"), for: .normal)
        playButton.setImage(#imageLiteral(resourceName: "icon_line_play"), for: .highlighted)
        playButton.layer.masksToBounds = true

        view.addSubview(tableView)
        view.addSubview(playButton)
        
        SongListCell.register(in: tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.load()
        
        setupNavigationItem()
        
        configure(item)
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        if let nav = navigationController {
            rect.size.height = nav.navigationBar.frame.height
            navigationTitleLabel?.frame = rect
        }
        
        rect.size = view.bounds.size
        tableView.frame = rect
        prototype.frame.size.width = rect.width
        
        rect.size.width = rect.width
        rect.size.height = 180
        header.frame = rect
        
        tableView.reloadData()
        
        rect.size.width = 60
        rect.size.height = rect.width
        rect.origin.x = (view.frame.width - rect.width) / 2
        rect.origin.y = view.frame.height - rect.height - 16
        playButton.frame = rect
        playButton.layer.cornerRadius = rect.width / 2
    }
    
    func setupNavigationItem() {
        guard navigationController != nil else { return }
        
        let barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_back"), style: .plain, target: self, action: #selector(self.didTapBack))
        navigationItem.leftBarButtonItem = barItem
        
        guard title != nil else { return }
        
        navigationTitleLabel = UILabel()
        navigationTitleLabel?.textAlignment = .center
        navigationItem.titleView = navigationTitleLabel
        
        var theme = UITheme()
        let attributedText = NSAttributedString(
            string: title!,
            attributes: [
                NSKernAttributeName: 2,
                NSFontAttributeName: theme.font.regular(11),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        
        navigationTitleLabel?.attributedText = attributedText
    }
    
    func didTapBack() {
        flowController.exit(true)
    }
    
    func didTapPlayButton() {
        guard item.cellItems.count > 0 else { return }
        
        interactor.selectSongsToPlay(.all)
    }
}

extension SongListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SongListCell.dequeue(from: tableView)
        let celItem = item.cellItems[indexPath.row]
        cell.configure(celItem)
        return cell
    }
}

extension SongListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellItem = item.cellItems[indexPath.row]
        prototype.configure(cellItem)
        return prototype.dynamicHeight + 12
    }
}


extension SongListViewController: SongListPresenterOutputProtocol {
    
    func displayTitle(_ aTitle: String) {
        title = aTitle
    }
    
    func displaySongs(_ type: PresenterSongListType) {
        switch type {
        case .artist(let info):
            var headerItem = SongListHeaderDisplayItem()
            headerItem.subtitleText = info.artist.genreText
            headerItem.titleText = info.artist.nameText
            headerItem.descriptionText = info.artist.bioText
            
            let cellItems = info.songs.map({ item -> SongListCellItem in
                var cellItem = SongListCellDisplayItem()
                cellItem.titleText = item.song.titleText
                return cellItem
            })
            
            var viewItem = SongListViewDisplayItem()
            viewItem.cellItems = cellItems
            viewItem.coverPhotoURLPath = info.songs.count > 0 ? info.songs[0].albums.count > 0 ? info.songs[0].albums[0].photoURLPath : "" : ""
            viewItem.headerItem = headerItem
            
            item = viewItem
            
        default:
            break
        }
    }
    
    func playSongs(_ songs: [Song.Data]) {
        flowController.showMusicPlayer(.present(self, true, duyogNavController), songs: songs)
    }
}
