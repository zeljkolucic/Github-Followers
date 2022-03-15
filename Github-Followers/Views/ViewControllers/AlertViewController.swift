//
//  GFAlertViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import UIKit

class AlertViewController: UIViewController {
    
    let containerView: AlertContainerView = {
        let view = AlertContainerView()
        return view
    }()
    
    private let titleLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .center, fontSize: 20)
        return label
    }()
    
    private let messageLabel: BodyLabel = {
        let label = BodyLabel(textAlignment: .center)
        return label
    }()
    
    private let actionButton: Button = {
        let button = Button(backgroundColor: .systemPink, title: "Ok")
        return button
    }()
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    // MARK: Initialization
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setConstraints()
        
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
    }
    
    // MARK: Configuration
    
    private func configureViewController() {
        view.backgroundColor = .black.withAlphaComponent(0.75)
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? ""
    }
    
    private func configureMessageLabel() {
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
    }
    
    private func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    // MARK: Layout
    
    private func setupLayout() {
        configureViewController()
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionButton)
    }
    
    private func setConstraints() {
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
    }

}
