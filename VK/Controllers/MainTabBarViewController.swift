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
        let vc1 = UINavigationController(rootViewController: FriendsViewController())
        let vc2 = UINavigationController(rootViewController: GroupsViewController())
        let vc3 = UINavigationController(rootViewController: UserViewController())

        vc1.tabBarItem.image = UIImage(systemName: "person.3.sequence")
        vc2.tabBarItem.image = UIImage(systemName: "folder.fill")
        vc3.tabBarItem.image = UIImage(systemName: "person")
        
        vc1.title = "Friend"
        vc2.title = "Group"
        vc3.title = "User"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }

}

