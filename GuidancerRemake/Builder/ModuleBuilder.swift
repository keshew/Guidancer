import UIKit
import MediaPlayer

protocol Builder: AnyObject {
    func buildProfile(router: ProfileRouterProtocol, author: Author?) -> UIViewController
    func buildGuest(router: GuestRouterProtocol) -> UIViewController
    func buildAudio(post: PostElement?, router: AudioRouterProtocol, isProfile: Bool) -> UIViewController
    func buildPost(post: PostElement?, router: PostRouterProtocol, player: AVPlayer) -> UIViewController
    func buildSearch(router: SearchRouterProtocol) -> UIViewController
    func buildLogin(router: LoginRouterProtocol) -> UIViewController
    func buildCreatePost(router: CreatePostRouterProtocol) -> UIViewController
    func buildMaps(router: MapsRouterProtocol) -> UIViewController
    func buildNotif(router: NotificationRouterProtocol) -> UIViewController
    func buildPickPlace(router: PickPlaceRouterProtocol) -> UIViewController
    func buildRegister(router: RegisterRouterProtocol) -> UIViewController
    func buildFollowers(router: FollowersRouterProtocol) -> UIViewController
}
class ModuleBuilder: Builder { 
    func buildProfile(router: ProfileRouterProtocol, author: Author?) -> UIViewController {
        let view = ProfileViewController()
        let network = NetworkManager()
        let presenter = ProfilePresenter(view: view, network: network, router: router, author: author)
        view.presenter = presenter
        return view
    }
    
    func buildGuest(router: GuestRouterProtocol) -> UIViewController {
        let view = GuestViewController()
        let network = NetworkManager()
        let presenter = GuestPresenter(view: view, network: network, router: router)
        view.presenters = presenter
        return view
    }
    
    func buildAudio(post: PostElement?, router: AudioRouterProtocol, isProfile: Bool) -> UIViewController {
        let view = AudioGuideViewController()
        let network = NetworkManager()
        let presenter = AudioPresenter(view: view, post: post, network: network, router: router, isProfile: isProfile)
        view.presenter = presenter
        return view
    }
    
    func buildPost(post: PostElement?, router: PostRouterProtocol, player: AVPlayer) -> UIViewController {
        let view = PostViewController()
        let network = NetworkManager()
        let presenter = PostPresenter(view: view, post: post, network: network, router: router, player: player)
        view.presenter = presenter
        return view
    }
    
    func buildSearch(router: SearchRouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let network = NetworkManager()
        let presenter = SearchPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildLogin(router: LoginRouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let network = NetworkManager()
        let presenter = LoginPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildCreatePost(router: CreatePostRouterProtocol) -> UIViewController {
        let view = CreatePostViewController()
        let network = NetworkManager()
        let presenter = CreatePostPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildMaps(router: MapsRouterProtocol) -> UIViewController {
        let view = MapsViewController()
        let network = NetworkManager()
        let presenter = MapsPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildNotif(router: NotificationRouterProtocol) -> UIViewController {
        let view = NotificationViewController()
        let network = NetworkManager()
        let presenter = NotificationPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildPickPlace(router: PickPlaceRouterProtocol) -> UIViewController {
        let view = PickPlaceViewController()
        let network = NetworkManager()
        let presenter = PickPlacePresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildRegister(router: RegisterRouterProtocol) -> UIViewController {
        let view = RegisterViewController()
        let network = NetworkManager()
        let presenter = RegisterPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildFollowers(router: FollowersRouterProtocol) -> UIViewController {
        let view = FollowersViewController()
        let network = NetworkManager()
        let presenter = FollowersPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
}
