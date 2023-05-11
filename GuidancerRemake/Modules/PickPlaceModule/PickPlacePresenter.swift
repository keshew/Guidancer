import Foundation

protocol PickPlacePresenterProtocol: AnyObject {
    init(view: PickPlaceViewProtocol, network: NetworkManagerProtocol, router: PickPlaceRouterProtocol?)
    var viewModel: PickPlaceViewModel? { get set }
}

class PickPlacePresenter {
    weak var view: PickPlaceViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: PickPlaceViewModel?
    var router: PickPlaceRouterProtocol?

    required init(view: PickPlaceViewProtocol, network: NetworkManagerProtocol, router: PickPlaceRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
}

extension PickPlacePresenter: PickPlacePresenterProtocol {
}
