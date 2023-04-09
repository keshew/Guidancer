import Foundation

protocol PlacesPresenterProtocol: AnyObject {
    init(view: PlacesViewProtocol, network: NetworkManagerProtocol, router: PlacesRouterProtocol?)
    var viewModel: PlacesViewModel? { get set }
}

class PlacesPresenter {
    weak var view: PlacesViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: PlacesViewModel?
    var router: PlacesRouterProtocol?

    required init(view: PlacesViewProtocol, network: NetworkManagerProtocol, router: PlacesRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
}

extension PlacesPresenter: PlacesPresenterProtocol {
}
