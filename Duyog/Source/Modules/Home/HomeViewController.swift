//
//  HomeViewController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 28/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var navigationTitleLabel: UILabel?
    var header: HomeHeader!
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        view.backgroundColor = theme.color.black
        
        header = HomeHeader()
        
        view.addSubview(header)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
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
    }
    
    func didTapMenu() {
        
    }
    
    func didTapSearch() {
        
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
