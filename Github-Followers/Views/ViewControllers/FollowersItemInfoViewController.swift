//
//  FollowerItemInfoViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 3.3.22..
//

import UIKit

protocol FollowersDelegate: AnyObject {
    
    func didTapGetFollowersButton()
    
}

class FollowersItemInfoViewController: ItemInfoViewController {
    
    weak var delegate: FollowersDelegate?
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: Configuration
    
    private func configure() {
        itemInfoViewLeft.configure(with: .followers, count: user.followers)
        itemInfoViewRight.configure(with: .following, count: user.following)
        button.configure(with: .systemGreen, title: "Get Followers")
    }
    
    // MARK: Actions
    
    override func didTapButton() {
        delegate?.didTapGetFollowersButton()
    }
    
}
