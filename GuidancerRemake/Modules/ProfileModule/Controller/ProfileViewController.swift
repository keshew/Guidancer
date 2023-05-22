import UIKit

protocol ProfileViewProtocol: AnyObject {
    func sucsess()
    func faillure(error: Error)
    func setupValue(author: Author?)
    var viewOfProfile: ProfileView { get set }
}

protocol MyProfileViewControllerDelegate: AnyObject {
    func didTapSettings()
}

class ProfileViewController: UIViewController, ProfileViewProtocol  {
    
    var presenter: ProfilePresenterProtocol!
    
    fileprivate enum UIConstants {
        static let collectionViewLayoutOffset: CGFloat = 20
        static let collectionViewLayoutHeight: CGFloat = 200
        static let layoutMinimumLineSpacing: CGFloat = 25
        static let layoutSectionBottomTopInset: CGFloat = 10
        static let layoutSectionLeftRightInset: CGFloat = 0
        static let scrollViewTopInset: CGFloat = 100
        static let viewOfProfileHeight: CGFloat = 300
        static let followButtonLeadingInset: CGFloat = 170
        static let followButtonTopInset: CGFloat = 205
    }
    
    lazy var viewOfProfile: ProfileView = {
        let view = ProfileView()
        view.followersButton.addTarget(self, action: #selector(followersButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let width = UIScreen.main.bounds.size.width - UIConstants.collectionViewLayoutOffset
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: UIConstants.layoutSectionBottomTopInset,
                                           left: UIConstants.layoutSectionLeftRightInset,
                                           bottom: UIConstants.layoutSectionBottomTopInset,
                                           right: UIConstants.layoutSectionLeftRightInset)
        layout.itemSize = CGSize(width: width,
                                 height: UIConstants.collectionViewLayoutHeight)
        layout.minimumLineSpacing = UIConstants.layoutMinimumLineSpacing
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let justView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var followButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFollowButton()
        configureView()
        configureCollectionView()
        print(presenter.author)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getPosts()
    }
    
    func sucsess() {
        self.collectionView.reloadData()
    }
    
    func setupValue(author: Author?) {
        self.viewOfProfile.setupUserInforamtion(image: author?.avatarURL,
                                                nickname: author?.nickname ?? "No name",
                                                numberOfLikes: author?.v,
                                                numberOfFollowers: author?.v)
    }
    
    func addAction() {
        viewOfProfile.followersButton.addTarget(self, action: #selector(followersButtonTapped), for: .touchUpInside)
    }
    
    func faillure(error: Error) {
        //make alert
        print("Error is", error)
    }
    
    @objc func buttonFollowTapped() {
        //carry on presenter
        if followButton.tintColor == UIColor(named: "green") {
            followButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
            followButton.tintColor = .black
        } else {
            followButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            followButton.tintColor = UIColor(named: "green")
        }
        followButton.transform = CGAffineTransform(scaleX: 0, y: 1)
        UIView.animate(withDuration: 0.5) {
            self.followButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    @objc func followersButtonTapped() {
        let navigationController = UINavigationController(rootViewController: presenter?.presentFollowers() ?? UIViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.viewModel?.postInforamtion?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = presenter?.viewModel?.postInforamtion?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchScreenCollectionViewCell.identifier, for: indexPath) as! SearchScreenCollectionViewCell
        cell.setupContent(post: .mock,
                          image: model?.imageUrl ?? "",
                          cityName: model?.title ?? "",
                          descriptionOfPlace: model?.text ?? "",
                          numberOfLikes: model?.v ?? 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = presenter?.viewModel?.postInforamtion?[indexPath.row]
        //upgrade
        guard let controller = presenter?.pushController(post: post, isProfile: true) else { return }
        let navVC = UINavigationController(rootViewController: controller)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

private extension ProfileViewController {
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(justView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(viewOfProfile)
        viewOfProfile.addSubview(followButton)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -UIConstants.scrollViewTopInset),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: justView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: justView.topAnchor),
            justView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            justView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollView.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: collectionView.heightAnchor),
            
            scrollView.widthAnchor.constraint(equalTo: viewOfProfile.widthAnchor),
            viewOfProfile.heightAnchor.constraint(equalToConstant: UIConstants.viewOfProfileHeight),
            
            
            viewOfProfile.leadingAnchor.constraint(equalTo: justView.leadingAnchor),
            viewOfProfile.topAnchor.constraint(equalTo: justView.topAnchor),
            justView.trailingAnchor.constraint(equalTo: viewOfProfile.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: viewOfProfile.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: justView.leadingAnchor),
            justView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            justView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            
            followButton.leadingAnchor.constraint(equalTo: viewOfProfile.leadingAnchor, constant: -UIConstants.followButtonLeadingInset),
            followButton.topAnchor.constraint(equalTo: viewOfProfile.topAnchor,constant: UIConstants.followButtonTopInset),
            viewOfProfile.trailingAnchor.constraint(equalTo: followButton.trailingAnchor),
        ])
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchScreenCollectionViewCell.self, forCellWithReuseIdentifier: SearchScreenCollectionViewCell.identifier)
    }
    
    func configureFollowButton() {
        followButton.isHidden = true
        followButton.addTarget(self, action: #selector(buttonFollowTapped), for: .touchUpInside)
    }
}

