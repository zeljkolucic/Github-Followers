//
//  FollowersViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import UIKit

class FollowersViewController: UIViewController {
    
    private var username: String?
    
    init(username: String?) {
        super.init(nibName: nil, bundle: nil)
        
        self.username = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setConstraints()
        
        getFollowers()
    }
    
    private func getFollowers() {
        guard let username = username else {
            presentGFAlertOnMainThread(title: "Error", message: "Username is empty.", buttonTitle: "Ok")
            return
        }
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, error in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Error", message: error!.rawValue, buttonTitle: "Ok")
                return
            }

            print("Followers.count = \(followers.count)")
            print(followers)
            
        }
    }
    
    private func configureBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        configureBackground()
        
    }
    
    private func setConstraints() {
        
    }


}
