import Foundation

protocol NotificationPresenterProtocol: AnyObject {
    init(view: NotificationViewProtocol, network: NetworkManagerProtocol, router: NotificationRouterProtocol?)
    var viewModel: NotificationViewModel? { get set }
}

class NotificationPresenter {
    weak var view: NotificationViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: NotificationViewModel?
    var router: NotificationRouterProtocol?

    required init(view: NotificationViewProtocol, network: NetworkManagerProtocol, router: NotificationRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
}

extension NotificationPresenter: NotificationPresenterProtocol {
}
