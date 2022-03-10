//
//  ItemInfoViewContorller.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 3.3.22..
//

import UIKit

class ItemInfoViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let itemInfoViewLeft: ItemInfoView = {
        let view = ItemInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemInfoViewRight: ItemInfoView = {
        let view = ItemInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var user: User
    
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
        
        configureViewController()
        setupLayout()
        setConstraints()
        
        configureButtonActions()
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(itemInfoViewLeft)
        stackView.addArrangedSubview(itemInfoViewRight)
        view.addSubview(button)
    }
    
    private func setConstraints() {
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: Configuration
    
    private func configureButtonActions() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc func didTapButton() {
        
    }
    
}
