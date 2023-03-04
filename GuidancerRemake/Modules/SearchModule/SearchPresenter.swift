import Foundation

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, network: NetworkManagerProtocol, router: SearchRouterProtocol?)
    var viewModel: SearchViewModelProtocol? { get set }
    func getInfoPost()
}

class SearchPresenter {
    weak var view: SearchViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: SearchViewModelProtocol?
    var router: SearchRouterProtocol?
    
    required init(view: SearchViewProtocol, network: NetworkManagerProtocol, router: SearchRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func getInfoPost() {
        viewModel = SearchViewModel()
        network?.getPost(completion: { [weak self] post in
            DispatchQueue.main.async {
                guard let self else { return }
                switch post {
                case .success(let posts):
                    self.viewModel?.searchViewModel = posts
                    self.view?.sucsess()
                case .failure(let error):
                    self.view?.faillure(error: error)
                }
            }
        })
    }
}

extension SearchPresenter: SearchPresenterProtocol {
}
