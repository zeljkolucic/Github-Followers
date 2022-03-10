//
//  FavoriteCell.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 10.3.22..
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let identifier = "FavoriteCell"
    
    let avatarImageView: AvatarImageView = {
        let imageView = AvatarImageView(frame: .zero)
        return imageView
    }()
    
    let usernameLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .left, fontSize: 26)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
    }
    
    private func setConstraints() {
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configure() {
        accessoryType = .disclosureIndicator
    }
    
}
