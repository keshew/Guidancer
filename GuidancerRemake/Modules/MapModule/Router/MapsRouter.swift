import UIKit

protocol MapsRouterProtocol: AnyObject {
}

class MapsRouter: MapsRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
}
