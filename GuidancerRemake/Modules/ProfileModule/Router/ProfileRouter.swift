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
//        if let navigationController = navigationController {
        guard let navigationController else { return UIViewController() }
            self.builder = ModuleBuilder()
//            let router = AudioRouter(navigationController: navigationController, builder: builder!)
        let router2 = AudioRouter(navigationController: navigationController, builder: builder!)
            let mainViewController = builder!.buildAudio(post: post, router: router2)
            if let sheet = mainViewController.sheetPresentationController {
                               sheet.detents = [.large()]
                           }
            return mainViewController
//                        print(post?.title)
//            navigationController.pushViewController(mainViewController, animated: true)
            
//            let navControl = UINavigationController()
//            let builder = ModuleBuilder()
//            let post = presenter?.viewModel?.postInforamtion![indexPath.row]
//            let router = PostRouter(navigationController: navControl, builder: builder)
//            let postController = builder.buildPost(post: post, router: router)
//               if let sheet = postController.sheetPresentationController {
//                   sheet.detents = [.large()]
//               }
//            print(post?.title)
//            self.viewOfProfile.window?.rootViewController?.present(postController, animated: true, completion: nil)
//        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
