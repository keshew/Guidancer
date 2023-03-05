import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, network: NetworkManagerProtocol, router: ProfileRouterProtocol?)
    var viewModel: ProfileViewModel? { get set }
    func sayHi()
    func pushController(post: PostElement?) -> UIViewController
}

class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: ProfileViewModel?
    var router: ProfileRouterProtocol?
    
    required init(view: ProfileViewProtocol, network: NetworkManagerProtocol, router: ProfileRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func pushController(post: PostElement?) -> UIViewController {
        return router?.initialPostController(post: post) ?? UIViewController()
    }
    
    func sayHi() {
        viewModel = ProfileViewModel()
        network?.getPost(completion: { [weak self] post in
            DispatchQueue.main.async {
                guard let self else { return }
                switch post {
                case .success(let posts):
                    self.viewModel?.postInforamtion = posts
                    self.view?.sucsess()
                case .failure(let error):
                    self.view?.faillure(error: error)
                }
            }
        })
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
}
