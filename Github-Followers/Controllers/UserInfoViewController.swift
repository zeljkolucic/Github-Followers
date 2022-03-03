//
//  UserInfoViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 2.3.22..
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let followersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: BodyLabel = {
        let label = BodyLabel(textAlignment: .center)
        return label
    }()
    
    private var username: String
    
    init(username: String) {
        self.username = username
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        setupLayout()
        setConstraints()
        
        getUser()
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneBarButton
    }
    
    private func setupLayout() {
        view.addSubview(headerView)
        view.addSubview(profileView)
        view.addSubview(followersView)
        view.addSubview(dateLabel)
    }
    
    private func setConstraints() {
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        profileView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        followersView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20).isActive = true
        followersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        followersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        followersView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: followersView.bottomAnchor, constant: 20).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func addChildViewController(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.didMove(toParent: self)
    }
    
    // MARK: Actions
    
    @objc private func didTapDoneButton() {
        dismiss(animated: true)
    }
    
    // MARK: Network
    
    private func getUser() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    let userInfoHeaderViewController = UserInfoHeaderViewController(user: user)
                    self.addChildViewController(child: userInfoHeaderViewController, to: self.headerView)
                    
                    let profileItemInfoViewController = ProfileItemInfoViewController(user: user)
                    self.addChildViewController(child: profileItemInfoViewController, to: self.profileView)
                    
                    let followersItemInfoViewController = FollowersItemInfoViewController(user: user)
                    self.addChildViewController(child: followersItemInfoViewController, to: self.followersView)
                    
                    let date = user.createdAt.convertToDisplayFormat()
                    self.dateLabel.text = "On GitHub since \(date)"
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    
    
}
