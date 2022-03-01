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
        imageView.image = UIImage(named: "empty-state-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        
        messageLabel.text = message
        setupLayout()
        setConstraints()
    }
    
    // MARK: Configuration
    
    private func setupLayout() {
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
