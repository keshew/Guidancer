import UIKit

protocol PlacesRouterProtocol: AnyObject {
}

class PlacesRouter: PlacesRouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
}
