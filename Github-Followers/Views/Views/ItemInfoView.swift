//
//  ItemInfoView.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 3.3.22..
//

import UIKit

enum ItemInfoType {
    case repos
    case gists
    case followers
    case following
}

class ItemInfoView: UIView {
    
    private let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .left, fontSize: 14)
        return label
    }()
    
    private let countLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .center, fontSize: 14)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func setupLayout() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
    }
    
    private func setConstraints() {
        symbolImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        symbolImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        symbolImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    func configure(with type: ItemInfoType, count: Int) {
        switch type {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
    
}
