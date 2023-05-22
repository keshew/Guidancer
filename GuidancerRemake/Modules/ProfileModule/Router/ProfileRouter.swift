import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func initialPostController(post: PostElement?, isProfile: Bool) -> UIViewController
    func presentFollowers() -> UIViewController
}

class ProfileRouter: ProfileRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialPostController(post: PostElement?, isProfile: Bool) -> UIViewController {
        guard let navigationController else { return UIViewController() }
        let router = AudioRouter(navigationController: navigationController, builder: builder!)
        let mainViewController = builder!.buildAudio(post: post, router: router, isProfile: isProfile)
        mainViewController.modalPresentationStyle = .fullScreen
        return mainViewController
    }
    
    func presentFollowers() -> UIViewController {
        guard let navigationController else { return UIViewController() }
        let router = FollowersRouter(navigationController: navigationController, builder: builder!)
        let mainViewController = builder!.buildFollowers(router: router)
        mainViewController.modalPresentationStyle = .fullScreen
        return mainViewController
    }
}
