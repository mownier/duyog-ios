//
//  PhotoPageController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 01/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class PhotoPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var sources: [PhotoPageSource] = [] {
        didSet {
            guard isViewLoaded else { return }
            
            createPages()
            selectPage(currentIndex, animated: false)
        }
    }
    
    var pages: [PhotoPage] = []
    var pendingIndex: Int = 0
    var currentIndex: Int = 0
    
    convenience init() {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .clear
        
        dataSource = self
        delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPages()
        selectPage(currentIndex, animated: false)
    }
    
    func selectPage(_ index: Int, animated: Bool = true) {
        guard pages.count > 0, index >= 0, index < pages.count else { return }
        
        var direction: UIPageViewControllerNavigationDirection = .forward
        if index < currentIndex {
            direction = .reverse
        }
        
        setViewControllers([pages[index]], direction: direction, animated: animated, completion: nil)
    }
    
    func createPages() {
        guard sources.count > 0 else { return }
        
        pages = sources.map({ source -> PhotoPage in
            let page = PhotoPage()
            page.source = source
            return page
        })
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageIndex(of: viewController), index < pages.count - 1 else { return nil }
        
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageIndex(of: viewController), index > 0 else { return nil }
        
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard pendingViewControllers.count > 0,
            let vc = pendingViewControllers.first as? PhotoPage,
            let index = pageIndex(of: vc) else {
            return
        }
        
        pendingIndex = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        
        currentIndex = pendingIndex
    }
    
    func pageIndex(of viewController: UIViewController) -> Int? {
        guard let page = viewController as? PhotoPage,
            let index = pages.index(of: page) else {
            return nil
        }
        
        return index
    }
}

class PhotoPage: UIViewController {
    
    var imageView: UIImageView!
    var source: PhotoPageSource = .image(nil)
    
    override func loadView() {
        super.loadView()
        
        var theme = UITheme()
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = theme.color.gray
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        
        view.addSubview(imageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch source {
        case .bundle(let name):
            imageView.image = UIImage(named: name)
        
        case .image(let image):
            imageView.image = image
        
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        let dimension = min(view.frame.width, view.frame.height)
        rect.size.width = dimension
        rect.size.height = rect.width
        rect.origin.x = (view.frame.width - rect.width) / 2
        rect.origin.y = (view.frame.height - rect.height) / 2
        imageView.frame = rect
    }
}

enum PhotoPageSource {
    
    case local(String)
    case bundle(String)
    case remote(String)
    case image(UIImage?)
}
