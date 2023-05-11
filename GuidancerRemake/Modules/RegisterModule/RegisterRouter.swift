import UIKit

protocol RegisterRouterProtocol: AnyObject {
}

class RegisterRouter: RegisterRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
}
