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

    func presentProfile() -> UIViewController {
//        guard let navigationController else { return UIViewController() }
//        let router = ProfileRouter(navigationController: navigationController, builder: builder!)
//        let mainViewController = builder!.buildProfile(router: router)
//        mainViewController.modalPresentationStyle = .fullScreen
        return ContainerViewController()
    }
}
