import UIKit

protocol PickPlaceRouterProtocol: AnyObject {
}

class PickPlaceRouter: PickPlaceRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
}
