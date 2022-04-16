//
//  GroupsViewController.swift
//  VK
//
//  Created by Арген on 01.04.2022.
//

import UIKit

class GroupsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Group"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
    }

}
