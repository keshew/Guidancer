import Foundation
import MediaPlayer

protocol PostPresenterProtocol: AnyObject {
    init(view: PostViewProtocol, post: PostElement?, network: NetworkManagerProtocol, router: PostRouterProtocol?, player: AVPlayer?)
    var viewModel: PostViewModelProtocol? { get set }
    func getInfoPost()
    func playTapped()
    func sliderChange()
}

class PostPresenter {
    weak var view: PostViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: PostViewModelProtocol?
    var router: PostRouterProtocol?
    var player: AVPlayer?
    var post: PostElement?

    required init(view: PostViewProtocol, post: PostElement?, network: NetworkManagerProtocol, router: PostRouterProtocol?, player: AVPlayer?) {
        self.view = view
        self.network = network
        self.router = router
        self.player = player
        self.post = post
    }
    
    func playTapped() {
        if player?.timeControlStatus == .playing {
            player?.pause()
        } else {
            player?.play()
        }
        
        view?.openPost.maxMinute.text = String(describing: Int(player?.currentItem?.asset.duration.seconds ?? 0)) + " seconds"
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000),
                                        queue: .main) { time in
            self.view?.openPost.progressView.minimumValue = Float(self.player?.currentItem?.asset.duration.seconds ?? 0)
            self.view?.openPost.progressView.minimumValue = 0
            self.view?.openPost.currentMinute.text = String(describing: Int(time.seconds)) + " seconds"
            self.view?.openPost.progressView.value = Float(time.seconds)
        }
    }
    
    func sliderChange() {
        player?.seek(to: CMTime(seconds: Double(view?.openPost.progressView.value ?? 0), preferredTimescale: 1000))
        self.view?.openPost.currentMinute.text = String(describing: Int(view?.openPost.progressView.value ?? 0))  + " seconds"
    }
    
    func getInfoPost() {
        viewModel = PostViewModel()
        network?.getPost(completion: { [weak self] post in
            DispatchQueue.main.async {
                guard let self else { return }
                switch post {
                case .success(_):
//                    self.viewModel?.postViewModel = posts
                    //put below realize in contriller 
                    self.view?.openPost.setupView(image: self.post?.imageUrl,
                                                  nickname: self.post?.author?.nickname ?? "NO NICKNAME",
                                                  firstTitle: self.post?.title ?? "NO TITLE",
                                                  secondTitle: self.post?.id ?? "NO SECOND TITLE",
                                                  text: self.post?.text ?? "NO TEXT")
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

extension PostPresenter: PostPresenterProtocol {
}
