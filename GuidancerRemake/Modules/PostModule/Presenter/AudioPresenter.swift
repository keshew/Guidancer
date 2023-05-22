import Foundation
import Kingfisher
import MediaPlayer

protocol AudioPresenterProtocol: AnyObject {
    init(view: AudioViewProtocol, post: PostElement?, network: NetworkManagerProtocol, router: AudioRouterProtocol?, isProfile: Bool)
    var viewModel: AudioViewModel? { get set }
    var player: AVPlayer? { get set }
    func getInfoPost()
    func tappedPlay()
    var post: PostElement? { get set }
    func deletePost()
    func editPost()
}

class AudioPresenter {
    weak var view: AudioViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: AudioViewModel?
    var router: AudioRouterProtocol?
    var player: AVPlayer?
    var post: PostElement?
    var isProfile: Bool

    required init(view: AudioViewProtocol, post: PostElement?, network: NetworkManagerProtocol, router: AudioRouterProtocol?, isProfile: Bool) {
        self.view = view
        self.network = network
        self.router = router
        self.post = post
        self.isProfile = isProfile
    }
    
    func tappedPlay() {
        guard let song = post?.audioUrl else { return }
        player = AVPlayer(url: URL(string: song)!)
        player?.play()
    }
    
    func getInfoPost() {
        if isProfile == false {
            self.view?.deleteButtonItem.isEnabled = false 
        }
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
                                                  text: self.post?.text ?? "",
                                                  numberOfLikes: self.post?.v ?? 0)
                    self.view?.backgroundImage.kf.setImage(with: URL(string: self.post?.imageUrl ?? ""))
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    func deletePost() {
        network?.deletePost(id: self.post?.id ?? "")
    }
    
    func editPost() {
        network?.editPost(id: self.post?.id ?? "",
                          location: "BLABLALBA", title: "TEST", description: "WQEKMQWOE")
    }
}

extension AudioPresenter: AudioPresenterProtocol {
}
