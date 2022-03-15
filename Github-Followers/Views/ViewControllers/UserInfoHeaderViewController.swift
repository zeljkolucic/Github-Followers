//
//  UserInfoHeaderViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 3.3.22..
//

import UIKit

class UserInfoHeaderViewController: UIViewController {

    private let avatarImageView: AvatarImageView = {
        let imageView = AvatarImageView(frame: .zero)
        return imageView
    }()
    
    private let usernameLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .left, fontSize: 34)
        return label
    }()
    
    private let nameLabel: SecondaryTitleLabel = {
        let label = SecondaryTitleLabel(fontSize: 18)
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = SFSymbols.location
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationLabel: SecondaryTitleLabel = {
        let label = SecondaryTitleLabel(fontSize: 18)
        return label
    }()
    
    private let bioLabel: BodyLabel = {
        let label = BodyLabel()
        label.numberOfLines = 3
        return label
    }()
    
    private var user: User
    
    init(user: User) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setConstraints()
        configureLayoutElements()
    }
    
    // MARK: Layout
    
    private func setupLayout() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    private func setConstraints() {
        avatarImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12).isActive = true
        locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        locationImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        locationImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bioLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    // MARK: Configuration
    
    private func configureLayoutElements() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { image in
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        
        usernameLabel.text = user.login
        nameLabel.text = user.name
        locationLabel.text = user.location ?? "No location"
        bioLabel.text = user.bio
        
    }
    
}
