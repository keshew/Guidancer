import UIKit

protocol LoginPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol, network: NetworkManagerProtocol, router: LoginRouterProtocol?)
    var viewModel: LoginViewModel? { get set }
    func enterInAcc()
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
    
    func enterInAcc() {
        //to network manager
        guard let url = URL(string: "http://31.31.203.226:4444/auth/login") else { return }
        let parameters = ["email": view?.emailTextField.textField.text, "password": view?.passwordTextField.textField.text]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode
                {
                case HTTPStatusCodeGroup.Success.rawValue :
                    self.view?.pushProfileController()
                default:
                    self.view?.showAlert()
                }
                guard let data else { return }
                do {
                    let jspn = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jspn)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func presentProfile() -> UIViewController {
        return (router?.presentProfile())!
    }
}

extension LoginPresenter: LoginPresenterProtocol {
}
