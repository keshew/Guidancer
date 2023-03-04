import UIKit

protocol PostViewProtocol: AnyObject {
    var openPost: PreviewPostView { get set }
}

final class PostViewController: UIViewController {
    
    fileprivate enum UIConstants {
        static var viewCornerRadius: CGFloat = 30
    }
    
    var presenter: PostPresenterProtocol?

    var openPost: PreviewPostView = {
        let view = PreviewPostView()
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter?.getInfoPost()
        addTarget()
    }
    
    @objc func playMusic() {
        presenter?.playTapped()
    }
    
    @objc func changeSlider() {
        presenter?.sliderChange()
    }
}

private extension PostViewController {
    
    func addTarget() {
        openPost.pauseButton.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        openPost.progressView.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
    }
    func configureView() {
        openPost.layer.zPosition = 1
        view.addSubview(openPost)
        NSLayoutConstraint.activate([
            openPost.topAnchor.constraint(equalTo: view.topAnchor),
            openPost.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: openPost.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: openPost.bottomAnchor)
        ])
    }
}

extension PostViewController: PostViewProtocol {
}
