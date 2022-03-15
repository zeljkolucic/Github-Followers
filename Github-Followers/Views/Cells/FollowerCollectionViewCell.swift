//
//  GFFollowerCollectionViewCell.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 17.2.22..
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "FollowerCell"
    
    let avatarImageView: AvatarImageView = {
        let imageView = AvatarImageView(frame: .zero)
        return imageView
    }()
    
    let usernameLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .center, fontSize: 16)
        return label
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func addSubviews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
    }
    
    private func setConstraints() {
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true // since the font is 16, leaving some extra space
    }
    
}
