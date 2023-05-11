import Foundation

protocol MapsPresenterProtocol: AnyObject {
    init(view: MapsViewProtocol, network: NetworkManagerProtocol, router: MapsRouterProtocol?)
    var viewModel: MapsViewModel? { get set }
    func getAllLoaction()
}

class MapsPresenter {
    weak var view: MapsViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: MapsViewModel?
    var router: MapsRouterProtocol?

    required init(view: MapsViewProtocol, network: NetworkManagerProtocol, router: MapsRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func getAllLoaction() {
        viewModel = MapsViewModel()
        network?.getPost(completion: { [weak self] post in
            DispatchQueue.main.async {
                guard let self else { return }
                switch post {
                case .success(let posts):
                    self.viewModel?.mapsViewModel = posts
                    self.view?.sucsess(array: posts)
                case .failure(let error):
                    self.view?.faillure(error: error)
                }
            }
        })    }
}

extension MapsPresenter: MapsPresenterProtocol {
}
