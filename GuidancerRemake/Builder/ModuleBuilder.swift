import UIKit
import MediaPlayer

protocol Builder: AnyObject {
    func buildProfile(router: ProfileRouterProtocol) -> UIViewController
    func buildGuest(router: GuestRouterProtocol) -> UIViewController
    func buildAudio(post: PostElement?, router: AudioRouterProtocol) -> UIViewController
    func buildPost(post: PostElement?, router: PostRouterProtocol, player: AVPlayer) -> UIViewController
    func buildSearch(router: SearchRouterProtocol) -> UIViewController
    func buildLogin(router: LoginRouterProtocol) -> UIViewController
    func buildCreatePost(router: CreatePostRouterProtocol) -> UIViewController
    func buildMaps(router: MapsRouterProtocol) -> UIViewController
}
class ModuleBuilder: Builder { 
    func buildProfile(router: ProfileRouterProtocol) -> UIViewController {
        let view = ProfileViewController()
        let network = NetworkManager()
        let presenter = ProfilePresenter(view: view, network: network, router: router)
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
    
    func buildAudio(post: PostElement?, router: AudioRouterProtocol) -> UIViewController {
        let view = AudioGuideViewController()
        let network = NetworkManager()
        let presenter = AudioPresenter(view: view, post: post, network: network, router: router)
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
}
