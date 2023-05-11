import Foundation

protocol RegisterPresenterProtocol: AnyObject {
    init(view: RegisterViewProtocol, network: NetworkManagerProtocol, router: RegisterRouterProtocol?)
    var viewModel: RegisterViewModel? { get set }
    func registerAccount()
}

class RegisterPresenter {
    weak var view: RegisterViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: RegisterViewModel?
    var router: RegisterRouterProtocol?

    required init(view: RegisterViewProtocol, network: NetworkManagerProtocol, router: RegisterRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func registerAccount() {
        network?.registerAccount(email: view?.emailTextField.textField.text ?? "",
                                 password: view?.passwordTextField.textField.text ?? "",
                                 nickname: view?.nicknameTextField.textField.text ?? "",
                                 sucsessCompletion: {
            self.view?.alertOK()
        }, faillureCompletion: {
            self.view?.alertError()
        })
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
}
