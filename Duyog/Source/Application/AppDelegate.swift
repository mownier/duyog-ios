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
    var flowController: FlowController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let song = Song(id: "s1", title: "Pero Atik Ra", genre: "Vispop", duration: 180, streamURL: "")
        let artist = Artist(id: "a1", name: "Jacky Chang", bio: "", genre: "Pop")
        let album = Album(id: "b1", photoURL: "", name: "Vispop", year: 2017)
        let data = Song.Data(song: song, artists: [artist], albums: [album])
        flowController = FlowController(window: window!)
        flowController.showMusicPlayer(.root(nav), songs: [data, data, data, data, data, data], moduleOutput: nil)
        return true
    }
}

func createNavigationController(_ root: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: root)
    nav.isNavigationBarHidden = true
    nav.navigationBar.isTranslucent = false
    return nav
}

var nav: UINavigationController {
    let nav = UINavigationController()
    nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
    nav.navigationBar.shadowImage = UIImage()
    nav.navigationBar.isTranslucent = true
    nav.navigationBar.tintColor = UIColor.white
    return nav
}

