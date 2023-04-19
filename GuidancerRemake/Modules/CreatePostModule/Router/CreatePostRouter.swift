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
}
