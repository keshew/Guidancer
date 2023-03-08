import Foundation

protocol CreatePostPresenterProtocol: AnyObject {
    init(view: CreatePostViewProtocol, network: NetworkManagerProtocol, router: CreatePostRouterProtocol?)
    var viewModel: CreatePostViewModel? { get set }
}

class CreatePostPresenter {
    weak var view: CreatePostViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: CreatePostViewModel?
    var router: CreatePostRouterProtocol?

    required init(view: CreatePostViewProtocol, network: NetworkManagerProtocol, router: CreatePostRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
}
