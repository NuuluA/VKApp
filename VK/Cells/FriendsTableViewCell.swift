//
//  FriendsTableViewCell.swift
//  VK
//
//  Created by Арген on 15.04.2022.
//

import UIKit
import SDWebImage

class FriendsTableViewCell: UITableViewCell {
    
    static let identifier = "FriendsTableViewCell"

    private let cellBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        cellBackgroundView.frame = bounds
    }

    public func configure(model: FriendsItem) {        
        nameLabel.text = model.firstName
        
        let urlImage = URL(string: "\(model.photo100 ?? "")")
        avatarImageView.sd_setImage(with: urlImage, completed: nil)
    }
}
extension FriendsTableViewCell {
    private func setConstraints() {
        addSubview(cellBackgroundView)
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
        
        cellBackgroundView.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 10),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        cellBackgroundView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
}
