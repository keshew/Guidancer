import UIKit
import AVKit

protocol PostRouterProtocol: AnyObject {
}

class PostRouter: PostRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController(post: PostElement?, player: AVPlayer) {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.buildPost(post: post, router: self, player: player) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
