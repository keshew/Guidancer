import UIKit

protocol CreatePostRouterProtocol: AnyObject {
}

class CreatePostRouter: CreatePostRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.buildCreatePost(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}