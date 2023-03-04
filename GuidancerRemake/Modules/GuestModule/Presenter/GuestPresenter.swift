import UIKit

protocol GuestPresenterProtocol: AnyObject {
    init(view: GuestViewProtocol, network: NetworkManagerProtocol, router: GuestRouterProtocol?)
    var viewModel: GuestViewModel? { get set }
    func getInfoPost()
}

class GuestPresenter {
    weak var view: GuestViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: GuestViewModel?
    var router: GuestRouterProtocol?

    required init(view: GuestViewProtocol, network: NetworkManagerProtocol, router: GuestRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func getInfoPost() {
        viewModel = GuestViewModel()
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

extension GuestPresenter: GuestPresenterProtocol {
}
