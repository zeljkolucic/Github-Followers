//
//  GFAvatarImageView.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 17.2.22..
//

import UIKit

class AvatarImageView: UIImageView {
    
    private let placeholderImage: UIImage = {
        let image = Images.placeholder
        return image!
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true // image inside imageView is clipped to imageView's corners
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
