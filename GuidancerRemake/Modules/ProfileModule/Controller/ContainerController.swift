import UIKit

class ContainerViewController: UIViewController {

    fileprivate enum MenuStatus {
        case closed
        case opened
    }
    
    fileprivate enum UIConstants {
        static let withDuration: CGFloat = 1
        static let usingSpringWithDamping: CGFloat = 1
        static let delay: CGFloat = 0
        static let initialSpringVelocity: CGFloat = 0
        static let menuControllerX: CGFloat = 200
        static let tableViewIdentifier = "cell"
    }
    
    private var menuStatus: MenuStatus = .closed
    let menuController = MenuController()
    let profileController = ProfileViewController()
    var delegate: MyProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC()
        setupSettingsItemBar()
    }
    
    @objc func buttonMenuTapped() {
        delegate?.didTapSettings()
    }
}

private extension ContainerViewController {
    func setupSettingsItemBar() {
        let item: UIBarButtonItem = {
            let itm = UIBarButtonItem(image: UIImage(named: "settings"),
                                      landscapeImagePhone: nil,
                                      style: .done,
                                      target: self,
                                      action: #selector(buttonMenuTapped))
            itm.tintColor = .black
            return itm
        }()
        navigationItem.rightBarButtonItem = item
    }
    
    func addChildVC() {
        delegate = self
        let navControl = UINavigationController()
        let builder = ModuleBuilder()
        let router = ProfileRouter(navigationController: navControl, builder: builder)
        let profile = builder.buildProfile(router: router)
        
        menuController.view.frame.origin.x = UIScreen.main.bounds.width
        addChild(profile)
        view.addSubview(profile.view)
        profile.didMove(toParent: self)
        
        addChild(menuController)
        view.addSubview(menuController.view)
        menuController.didMove(toParent: self)
    }
}

extension ContainerViewController: MyProfileViewControllerDelegate {
    func didTapSettings() {
        switch menuStatus {
        case .closed:
            UIView.animate(withDuration: UIConstants.withDuration,
                           delay: UIConstants.delay,
                           usingSpringWithDamping: UIConstants.usingSpringWithDamping,
                           initialSpringVelocity: UIConstants.initialSpringVelocity,
                           options: .curveEaseInOut) {
                self.menuController.view.frame = CGRect(origin: CGPoint(),
                                                        size: CGSize(width: UIScreen.main.bounds.width,
                                                                     height: UIScreen.main.bounds.height))
                self.menuController.view.frame.origin.x = self.menuController.view.frame.size.width - UIConstants.menuControllerX
            } completion: { done in
                if done {
                    self.menuStatus = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: UIConstants.withDuration,
                           delay: UIConstants.delay,
                           usingSpringWithDamping: UIConstants.usingSpringWithDamping,
                           initialSpringVelocity: UIConstants.initialSpringVelocity,
                           options: .curveEaseInOut) {
                self.menuController.view.frame.origin.x = UIScreen.main.bounds.height
            } completion: { done in
                if done {
                    self.menuStatus = .closed
                }
            }
        }
    }
}
