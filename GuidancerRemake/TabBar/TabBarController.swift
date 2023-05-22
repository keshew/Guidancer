import UIKit

final class TabBarViewController: UITabBarController {
    
    var author: Author?
    
    required init(author: Author?) {
        self.author = author
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        let navControl = UINavigationController()
        let builder = ModuleBuilder()
        let createPostRouter = CreatePostRouter(navigationController: navControl, builder: builder)
        let searchRouter = SearchRouter(navigationController: navControl, builder: builder)
        let mapsRouter = MapsRouter(navigationController: navControl, builder: builder)
        let notifRouter = NotificationRouter(navigationController: navControl, builder: builder)
        let profileRouter = ProfileRouter(navigationController: navControl, builder: builder)
        
        setViewControllers([
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildMaps(router: mapsRouter)),
                image: UIImage(systemName: "map.circle.fill")

            ),
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildSearch(router: searchRouter)),
                image: UIImage(systemName: "magnifyingglass")
            ),
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildCreatePost(router: createPostRouter)),
                image: UIImage(named: "PostModule")
            ),
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildNotif(router: notifRouter)),
                image: UIImage(named: "FavoriteModule")
            ),
            generateViewControllers(
                viewController: UINavigationController(rootViewController: builder.buildProfile(router: profileRouter, author: author)),
                image: UIImage(named: "ProfileModule")
            )],animated: true)
    }
    
    private func generateViewControllers(viewController: UINavigationController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .gGreen
        tabBar.unselectedItemTintColor = .gBlack
    }
}

