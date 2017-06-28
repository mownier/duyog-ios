//
//  AppDelegate.swift
//  Duyog
//
//  Created by Mounir Ybanez on 26/06/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navRoot = InitialViewController()
        let nav = createNavigationController(navRoot)
        window?.rootViewController = nav
        return true
    }
}

func createNavigationController(_ root: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: root)
    nav.isNavigationBarHidden = true
    nav.navigationBar.isTranslucent = false
    return nav
}

