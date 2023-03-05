import Foundation
import Kingfisher
import MediaPlayer

protocol AudioPresenterProtocol: AnyObject {
    init(view: AudioViewProtocol, post: PostElement?, network: NetworkManagerProtocol, router: AudioRouterProtocol?)
    var viewModel: AudioViewModel? { get set }
    func getInfoPost()
    func tappedPlay()
    var post: PostElement? { get set }
}

class AudioPresenter {
    weak var view: AudioViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: AudioViewModel?
    var router: AudioRouterProtocol?
    var player: AVPlayer?
    var post: PostElement?

    required init(view: AudioViewProtocol, post: PostElement?, network: NetworkManagerProtocol, router: AudioRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
        self.post = post
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
                    self.view?.openPost.setupView(image: self.post?.author?.avatarURL,
                                                  nickname: self.post?.author?.nickname ?? "",
                                                  firstTitle: self.post?.title ?? "",
                                                  text: self.post?.text ?? "")
                    self.view?.backgroundImage.kf.setImage(with: URL(string: self.post?.imageUrl ?? ""))
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

extension AudioPresenter: AudioPresenterProtocol {
}
