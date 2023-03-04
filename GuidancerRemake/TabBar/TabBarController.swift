import UIKit

final class TabBarViewController: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        let navControl = UINavigationController()
        let builder = ModuleBuilder()
        let guestRouter = GuestRouter(navigationController: navControl, builder: builder)
        let postRouter = AudioRouter(navigationController: navControl, builder: builder)
        let searchRouter = SearchRouter(navigationController: navControl, builder: builder)
        setViewControllers([
            generateViewControllers(
                viewController: UINavigationController(rootViewController: ContainerViewController()),
                title: "Profile",
                image: UIImage(named: "user_cicrle_light")
            ),
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildGuest(router: guestRouter)),
                title: "Guest",
                image: UIImage(named: "user_cicrle_light")
            ),
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildAudio(router: postRouter)),
                title: "Post",
                image: UIImage(named: "user_cicrle_light")
            ),
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildSearch(router: searchRouter)),
                title: "Search",
                image: UIImage(named: "user_cicrle_light")
            )],animated: true)
    }
    
    private func generateViewControllers(viewController: UINavigationController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .gGreen
        tabBar.unselectedItemTintColor = .gBlack
    }
}

