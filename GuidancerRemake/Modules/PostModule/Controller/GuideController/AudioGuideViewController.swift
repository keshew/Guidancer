import UIKit

protocol AudioViewProtocol: AnyObject {
    var openPost: PostView { get set }
    var backgroundImage: UIImageView { get set }
}

final class AudioGuideViewController: UIViewController {
    
    var presenter: AudioPresenterProtocol?
    
    fileprivate enum UIConstants {
        static var viewCornerRadius: CGFloat = 50
        static var openPostTopInset: CGFloat = -50
    }
    
    var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var openPost: PostView = {
        let view = PostView()
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getInfoPost()
        configureView()
        play()
    }
    
    @objc func playButtonTapped() {
        presenter?.tappedPlay()
    }
}

private extension AudioGuideViewController {
    
    func play() {
        openPost.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    func configureView() {
        openPost.layer.zPosition = 1
        view.addSubview(openPost)
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            
            openPost.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: UIConstants.openPostTopInset),
            openPost.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: openPost.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: openPost.bottomAnchor, constant: 20),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
        ])
    }
}


extension AudioGuideViewController: AudioViewProtocol {
}
