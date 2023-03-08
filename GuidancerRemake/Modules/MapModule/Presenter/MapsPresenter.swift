import Foundation

protocol MapsPresenterProtocol: AnyObject {
    init(view: MapsViewProtocol, network: NetworkManagerProtocol, router: MapsRouterProtocol?)
    var viewModel: MapsViewModel? { get set }
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
}

extension MapsPresenter: MapsPresenterProtocol {
}
