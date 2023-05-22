import UIKit

protocol LoginPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol, network: NetworkManagerProtocol, router: LoginRouterProtocol?)
    var viewModel: LoginViewModel? { get set }
    func loginInAccount()
    func presentProfile(author: Author) -> UIViewController
    func presentRegister() -> UIViewController
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
                                sucsessCompletion: { [weak self] author in
            DispatchQueue.main.async {
                guard let self else { return }
                switch author {
                case .success(let authors):
                    self.view?.pushProfileController(author: authors)
                case .failure(let error):
                    print("ERROR IS", error)
                }
            }
        },
                                faillureCompletion: {
            self.view?.showAlert()
        })
    }
    
    func presentProfile(author: Author) -> UIViewController {
        return TabBarViewController(author: author)
    }
    
    func presentRegister() -> UIViewController {
        guard let controller = router?.presentRegisterModule() else { return UIViewController()}
        return controller
    }
}

extension LoginPresenter: LoginPresenterProtocol {
}
