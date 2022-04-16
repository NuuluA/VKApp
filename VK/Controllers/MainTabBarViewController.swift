//
//  ViewController.swift
//  VK
//
//  Created by Арген on 01.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    private func setupVC() {
        let vc2 = UINavigationController(rootViewController: FriendsViewController())
        let vc3 = UINavigationController(rootViewController: PhotosViewController())
        let vc4 = UINavigationController(rootViewController: GroupsViewController())
        let vc5 = UINavigationController(rootViewController: UserViewController())

        
        vc2.tabBarItem.image = UIImage(systemName: "person.3.sequence")
        vc3.tabBarItem.image = UIImage(systemName: "folder.fill")
        vc4.tabBarItem.image = UIImage(systemName: "photo")
        vc5.tabBarItem.image = UIImage(systemName: "person")
        
        vc2.title = "Friend"
        vc3.title = "Group"
        vc4.title = "Photo"
        vc5.title = "User"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc2, vc3, vc4, vc5], animated: true)
    }

}

