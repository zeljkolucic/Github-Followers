//
//  ProfileItemInfoViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 3.3.22..
//

import UIKit

class ProfileItemInfoViewController: ItemInfoViewController {
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: Configuration
    
    private func configure() {
        itemInfoViewLeft.configure(with: .repos, count: user.publicRepos)
        itemInfoViewRight.configure(with: .gists, count: user.publicGists)
        button.configure(with: .systemPurple, title: "Github Profile")
    }
    
}
