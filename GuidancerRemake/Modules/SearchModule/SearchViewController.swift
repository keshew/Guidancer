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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionViews()
        setupSearch()
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
}

private extension SearchViewController {
    func setupSearch() {
        navigationItem.searchController = searchController
    }
    
    func setupLayout() {
        layout.itemSize = CGSize(width: 380, height: 200)
        layout.scrollDirection = .vertical
    }
    
    func setupCollectionViews() {
        view.backgroundColor = .white
        collectionView = UICollectionView(
            frame: CGRect(),
            collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchScreenCollectionViewCell.self,
                                 forCellWithReuseIdentifier: SearchScreenCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),

        ])
    }
}


extension SearchViewController: SearchViewProtocol {
}
