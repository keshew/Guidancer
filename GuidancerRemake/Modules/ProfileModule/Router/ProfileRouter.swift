import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func initialPostController(post: PostElement?) -> UIViewController
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
    
    func initialPostController(post: PostElement?) -> UIViewController {
        guard let navigationController else { return UIViewController() }
        let router = AudioRouter(navigationController: navigationController, builder: builder!)
        let mainViewController = builder!.buildAudio(post: post, router: router)
        mainViewController.modalPresentationStyle = .fullScreen
        return mainViewController
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
