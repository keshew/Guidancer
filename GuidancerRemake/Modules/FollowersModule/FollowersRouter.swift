import UIKit

protocol FollowersRouterProtocol: AnyObject {
}

class FollowersRouter: FollowersRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
}
