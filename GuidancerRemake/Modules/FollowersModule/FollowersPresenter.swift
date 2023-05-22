import Foundation

protocol FollowersPresenterProtocol: AnyObject {
    init(view: FollowersViewProtocol, network: NetworkManagerProtocol, router: FollowersRouterProtocol?)
    var viewModel: FollowersViewModel? { get set }
}

class FollowersPresenter {
    weak var view: FollowersViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: FollowersViewModel?
    var router: FollowersRouterProtocol?

    required init(view: FollowersViewProtocol, network: NetworkManagerProtocol, router: FollowersRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
}

extension FollowersPresenter: FollowersPresenterProtocol {
}
