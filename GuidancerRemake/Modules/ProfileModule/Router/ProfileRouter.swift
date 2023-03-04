import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func initialPost(post: PostElement?)
}

class ProfileRouter: ProfileRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.buildProfile(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func initialPost(post: PostElement?) {
        if let navigationController = navigationController {
            let buidler = ModuleBuilder()
            let router = PostRouter(navigationController: navigationController, builder: buidler)
            guard let mainViewController = builder?.buildPost(post: post, router: router) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
}
