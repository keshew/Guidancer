import UIKit
import MediaPlayer

protocol Builder: AnyObject {
    func buildProfile(router: ProfileRouterProtocol) -> UIViewController
    func buildGuest(router: GuestRouterProtocol) -> UIViewController
    func buildAudio(post: PostElement?, router: AudioRouterProtocol) -> UIViewController
    func buildPost(router: PostRouterProtocol) -> UIViewController
    func buildSearch(router: SearchRouterProtocol) -> UIViewController
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
    
    func buildPost(router: PostRouterProtocol) -> UIViewController {
        let view = PostViewController()
        let network = NetworkManager()
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp3")!))
        let presenter = PostPresenter(view: view, network: network, router: router, player: player)
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
}