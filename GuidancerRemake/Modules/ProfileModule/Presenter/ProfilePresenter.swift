import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, network: NetworkManagerProtocol, router: ProfileRouterProtocol?, author: Author?)
    var viewModel: ProfileViewModel? { get set }
    var author: Author? { get set }
    func getPosts()
    func pushController(post: PostElement?, isProfile: Bool) -> UIViewController
    func presentFollowers() -> UIViewController
}

class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: ProfileViewModel?
    var router: ProfileRouterProtocol?
    var author: Author?
    
    required init(view: ProfileViewProtocol, network: NetworkManagerProtocol, router: ProfileRouterProtocol?, author: Author?) {
        self.view = view
        self.network = network
        self.router = router
        self.author = author
    }
    
    func pushController(post: PostElement?, isProfile: Bool) -> UIViewController {
        return router?.initialPostController(post: post, isProfile: isProfile) ?? UIViewController()
    }
    
    func presentFollowers() -> UIViewController {
        return router?.presentFollowers() ?? UIViewController()
    }
    
    func getPosts() {
        viewModel = ProfileViewModel()
        network?.getPost(completion: { [weak self] post in
            DispatchQueue.main.async {
                guard let self else { return }
                switch post {
                case .success(let posts):
                    self.viewModel?.postInforamtion = posts
                    self.view?.sucsess()
                    self.view?.setupValue(author: self.author)
                case .failure(let error):
                    self.view?.faillure(error: error)
                }
            }
        })
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
}
