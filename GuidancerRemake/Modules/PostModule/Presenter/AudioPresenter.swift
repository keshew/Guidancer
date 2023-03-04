import Foundation
import Kingfisher
import MediaPlayer

protocol AudioPresenterProtocol: AnyObject {
    init(view: AudioViewProtocol, network: NetworkManagerProtocol, router: AudioRouterProtocol?)
    var viewModel: AudioViewModel? { get set }
    func getInfoPost()
    func tappedPlay()
}

class AudioPresenter {
    weak var view: AudioViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: AudioViewModel?
    var router: AudioRouterProtocol?
    var player: AVPlayer?

    required init(view: AudioViewProtocol, network: NetworkManagerProtocol, router: AudioRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func tappedPlay() {
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp3")!))
//        print("player?.play()")
    }
    
    func getInfoPost() {
        viewModel = AudioViewModel()
        network?.getPost(completion: { [weak self] post in
            DispatchQueue.main.async {
                guard let self else { return }
                switch post {
                case .success(let posts):
                    self.viewModel?.postModel = posts
                    self.view?.openPost.setupView(image: posts.first?.author?.avatarURL,
                                                  nickname: posts.first?.author?.nickname ?? "",
                                                  firstTitle: posts.first?.title ?? "",
                                                  text: posts.first?.text ?? "")
                    self.view?.backgroundImage.kf.setImage(with: URL(string: posts.first?.imageUrl ?? ""))
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

extension AudioPresenter: AudioPresenterProtocol {
}
