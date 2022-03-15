//
//  SearchViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import UIKit

class SearchViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.githubLogo
        return imageView
    }()
    
    private let usernameTextField: TextField = {
        let textField = TextField()
        return textField
    }()
    
    private let getFollowersButton: Button = {
        let button = Button(backgroundColor: .systemGreen, title: "Get Followers")
        return button
    }()
    
    private var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }

    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        addSubviews()
        setConstraints()
        
        createDismissKeyboardTapGesture()
        configureTextFieldDelegate()
        configureButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(getFollowersButton)
    }
    
    private func setConstraints() {
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        getFollowersButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        getFollowersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        getFollowersButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: Configuration
    
    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureTextFieldDelegate() {
        usernameTextField.delegate = self
    }
    
    private func configureButtonAction() {
        getFollowersButton.addTarget(self, action: #selector(didTapGetFollowersButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc private func didTapGetFollowersButton() {
        guard isUsernameEntered else {
            presentAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for.", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followersViewController = FollowersViewController(username: usernameTextField.text!)
        navigationController?.pushViewController(followersViewController, animated: true)
    }

}

// MARK: Text Field Delegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocapitalizationType = .none
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapGetFollowersButton()
        return true
    }
    
}
