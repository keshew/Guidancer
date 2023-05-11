import UIKit

protocol LoginRouterProtocol: AnyObject {
    func presentProfile() -> UIViewController
    func presentRegisterModule() -> UIViewController
}

class LoginRouter: LoginRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }

    func presentProfile() -> UIViewController {
        return ContainerViewController()
    }
    
    func presentRegisterModule() -> UIViewController {
        guard let navigationController else { return UIViewController() }
        guard let builder = builder else { return UIViewController() }
        let router = RegisterRouter(navigationController: navigationController, builder: builder)
        let mainViewController = builder.buildRegister(router: router)
        mainViewController.modalPresentationStyle = .fullScreen
        return mainViewController
    }
}
