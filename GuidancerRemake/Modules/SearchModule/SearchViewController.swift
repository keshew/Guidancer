import UIKit

protocol SearchViewProtocol: AnyObject {
    func sucsess()
    func faillure(error: Error)
}

final class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    var collectionView: UICollectionView!
    let searchController = UISearchController()
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private lazy var popularButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Popular", for: .normal)
        btn.titleLabel?.font = .medium21
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    private lazy var followedButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Followed", for: .normal)
        btn.titleLabel?.font = .medium18
        btn.setTitleColor(.gray, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionViews()
        setupSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getInfoPost()
    }
    
    func sucsess() {
        self.collectionView.reloadData()
    }
    
    func faillure(error: Error) {
        //make alert
        print("Error is", error)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.viewModel?.searchViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchScreenCollectionViewCell.identifier, for: indexPath) as! SearchScreenCollectionViewCell
        let model = presenter?.viewModel?.searchViewModel?[indexPath.row]
        cell.setupContent(post: .mock, image: model?.imageUrl ?? "",
                          cityName: model?.title ?? "kek",
                          descriptionOfPlace: model?.text ?? "")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = presenter?.viewModel?.searchViewModel?[indexPath.row]
        //upgrade
        guard let controller = presenter?.pushController(post: post) else { return }
        let navVC = UINavigationController(rootViewController: controller)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}


private extension SearchViewController {
    func setupSearch() {
        navigationItem.searchController = searchController
    }
    
    func setupLayout() {
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 200)
        layout.scrollDirection = .vertical
    }
    
    func setupCollectionViews() {
        view.backgroundColor = .white
        collectionView = UICollectionView(
            frame: CGRect(),
            collectionViewLayout: layout)
        view.addSubview(collectionView)
        view.addSubview(followedButton)
        view.addSubview(popularButton)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchScreenCollectionViewCell.self,
                                 forCellWithReuseIdentifier: SearchScreenCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 7),
            popularButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            followedButton.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 20),
            followedButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            collectionView.topAnchor.constraint(equalTo: popularButton.bottomAnchor,constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
        ])
    }
}


extension SearchViewController: SearchViewProtocol {
}
