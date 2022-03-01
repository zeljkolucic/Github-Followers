//
//  FollowersViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import UIKit

class FollowersViewController: UIViewController {
    
    enum Section { // enum is hashable by default
        case main
    }
    
    private var username: String?
    private var followers: [Follower] = []
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String?) {
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
        configureCollectionView()
        setupLayout()
        setConstraints()
        
        configureDataSource()
        getFollowers()
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        
    }
    
    // MARK: Collection View Configuration
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnsFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier )
    }
    
    private func createThreeColumnsFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12 // padding of the whole collection view
        let minimumItemSpacing: CGFloat = 10 // spacing between cells
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier, for: indexPath) as? FollowerCollectionViewCell else {
                fatalError("Cannot create new cell.")
            }
            
            cell.usernameLabel.text = follower.login
            return cell
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true) // no need to call it from the main thread
    }
    
    // MARK: Network
    
    private func getFollowers() {
        guard let username = username else {
            presentGFAlertOnMainThread(title: "Error", message: "Username is empty.", buttonTitle: "Ok")
            return
        }
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                self.followers = followers
                self.reloadData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}
