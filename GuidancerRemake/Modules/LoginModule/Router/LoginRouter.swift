import UIKit

protocol LoginRouterProtocol: AnyObject {
    func presentProfile() -> UIViewController
}

class LoginRouter: LoginRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.buildLogin(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func presentProfile() -> UIViewController {
        guard let navigationController else { return UIViewController() }
        let router = ProfileRouter(navigationController: navigationController, builder: builder!)
        let mainViewController = builder!.buildProfile(router: router)
        mainViewController.modalPresentationStyle = .fullScreen
        return mainViewController
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}