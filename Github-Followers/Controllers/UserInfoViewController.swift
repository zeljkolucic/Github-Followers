//
//  UserInfoViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 2.3.22..
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private var username: String!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.username = username
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
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneBarButton
    }
    
    private func setupLayout() {
        
    }
    
    private func setConstraints() {
        
    }
    
    @objc private func didTapDoneButton() {
        dismiss(animated: true)
    }
    
    
}
