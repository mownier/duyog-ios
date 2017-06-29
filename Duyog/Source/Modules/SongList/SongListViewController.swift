//
//  SongListViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 29/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController {

    var navigationTitleLabel: UILabel?
    
    var header: SongListHeader!
    var tableView: UITableView!
    var prototype: SongListCell!
    
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
        
        view.addSubview(tableView)
        
        SongListCell.register(in: tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let _ = navigationController?.popViewController(animated: true)
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
