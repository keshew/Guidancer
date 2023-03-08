import Foundation

protocol LoginPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol, network: NetworkManagerProtocol, router: LoginRouterProtocol?)
    var viewModel: LoginViewModel? { get set }
}

class LoginPresenter {
    weak var view: LoginViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: LoginViewModel?
    var router: LoginRouterProtocol?

    required init(view: LoginViewProtocol, network: NetworkManagerProtocol, router: LoginRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
}

extension LoginPresenter: LoginPresenterProtocol {
}
