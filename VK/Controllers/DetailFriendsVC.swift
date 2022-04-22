//
//  DetailFriendsVC.swift
//  VK
//
//  Created by Арген on 17.04.2022.
//

import UIKit
import SDWebImage

class DetailFriendsVC: UIViewController {
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButtonImage: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeVc), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        view.backgroundColor = .systemBackground
    }
    
    @objc private func closeVc() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    func configure(model: FriendsItem) {
        let urlImage = URL(string: "\(model.photo100 ?? "")")
        avatarImageView.sd_setImage(with: urlImage, completed: nil)
        nameLabel.text = model.firstName
    }
}

extension DetailFriendsVC {
    private func setConstraints() {
        view.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15),
            nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(closeButtonImage)
        NSLayoutConstraint.activate([
            closeButtonImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            closeButtonImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
