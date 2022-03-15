//
//  EmptyStateView.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 1.3.22..
//

import UIKit

class EmptyStateView: UIView {
    
    private let messageLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .center, fontSize: 28)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.emptyStateLogo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    convenience init(message: String) {
        self.init(frame: .zero)
        
        messageLabel.text = message
    }
    
    // MARK: Layout
    
    private func addSubviews() {
        addSubview(messageLabel)
        addSubview(logoImageView)
    }
    
    private func setConstraints() {
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170).isActive = true
    }
    
}
