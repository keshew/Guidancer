import UIKit

protocol SearchRouterProtocol: AnyObject {
    func initialPostController(post: PostElement?) -> UIViewController 
}

class SearchRouter: SearchRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialPostController(post: PostElement?) -> UIViewController {
        guard let navigationController else { return UIViewController() }
        let router = AudioRouter(navigationController: navigationController, builder: builder!)
        let mainViewController = builder!.buildAudio(post: post, router: router)
        mainViewController.modalPresentationStyle = .fullScreen
        return mainViewController
    }
}
