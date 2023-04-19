import UIKit

protocol LoginPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol, network: NetworkManagerProtocol, router: LoginRouterProtocol?)
    var viewModel: LoginViewModel? { get set }
    func loginInAccount()
    func presentProfile() -> UIViewController
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
    
    func loginInAccount() {
        network?.loginInAccount(email: view?.emailTextField.textField.text ?? "",
                                password: view?.passwordTextField.textField.text ?? "",
                                sucsessCompletion: {
            self.view?.pushProfileController()
        },                      faillureCompletion: {
            self.view?.showAlert()
        })
    }
    
    func presentProfile() -> UIViewController {
        guard let controller = router?.presentProfile() else { return UIViewController()}
        return controller
    }
}

extension LoginPresenter: LoginPresenterProtocol {
}
