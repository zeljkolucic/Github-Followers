//
//  FollowersViewController.swift
//  Github-Followers
//
//  Created by Zeljko Lucic on 16.2.22..
//

import UIKit

class FollowersViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private var username: String?
    private var followers: [Follower] = []
    private var page: Int = 1
    private var hasMoreFollowers: Bool = true
    
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
        
        configureDataSource()
        getFollowers(page: page)
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = username
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
    }
    
    // MARK: Collection View Configuration
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnsFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier )
        collectionView.delegate = self
    }
    
    private func createThreeColumnsFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
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
            NetworkManager.shared.downloadImage(from: follower.avatarUrl) { image in
                DispatchQueue.main.async {
                    cell.avatarImageView.image = image
                }
            }
            return cell
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Network
    
    private func getFollowers(page: Int) {
        guard let username = username else {
            presentAlertOnMainThread(title: "Error", message: "Username is empty.", buttonTitle: "Ok")
            return
        }
        
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let meessage = "This user doesn't have any followers. Go follow them!"
                    self.showEmptyStateView(with: meessage, view: self.view)
                }
                self.reloadData()
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}

// MARK: Collection View Delegate

extension FollowersViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if !hasMoreFollowers { return }
            page += 1
            getFollowers(page: page)
        }
    }
    
}
