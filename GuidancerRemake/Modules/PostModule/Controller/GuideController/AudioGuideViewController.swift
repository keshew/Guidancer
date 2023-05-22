import UIKit

protocol AudioViewProtocol: AnyObject {
    var openPost: PostView { get set }
    var backgroundImage: UIImageView { get set }
    var deleteButtonItem: UIBarButtonItem { get set }
}

final class AudioGuideViewController: UIViewController {
    
    var presenter: AudioPresenterProtocol?
    
    fileprivate enum UIConstants {
        static var viewCornerRadius: CGFloat = 50
        static var openPostTopInset: CGFloat = -50
    }
    
    var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
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
    
    private lazy var toBackBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(dismissVC))
        item.tintColor = .gGreen
        return item
    }()
    
    lazy var deleteButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(systemItem: .compose, menu: makeMenu())
        item.tintColor = .gGreen
        return item
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getInfoPost()
        configureView()
        addTarget()
    }

    func deletePost() {
        presenter?.deletePost()
        dismiss(animated: true)
    }
    
    func editPost() {
        presenter?.editPost()
        dismiss(animated: true)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func navigationTapped() {
        let profile = UINavigationController(rootViewController: AudioGuideMapViewController())
        profile.modalPresentationStyle = .fullScreen
        present(profile, animated: true, completion: nil)
    }
    
    @objc func pushPostController() {
        presenter?.tappedPlay()
        guard let player = presenter?.player else { return }
        let navControl = UINavigationController()
        let builder = ModuleBuilder()
        let router = PostRouter(navigationController: navControl, builder: builder)
        let post = builder.buildPost(post: presenter?.post, router: router, player: player)
           if let sheet = post.sheetPresentationController {
               sheet.detents = [.large()]
           }
        present(post, animated: true)
    }
}

private extension AudioGuideViewController {
    
    func makeMenu() -> UIMenu {
        let deleteItem = UIAction(title: "Удалить", image: UIImage (systemName: "delete.left.fill")) { _ in
            self.deletePost()
        }
        
        let remakeItem = UIAction(title: "Редактировать", image: UIImage (systemName: "rectangle.and.pencil.and.ellipsis")) { _ in
            self.editPost()
        }
        return UIMenu(title: "", children: [deleteItem,remakeItem])
    }
    
    func addTarget() {
        openPost.playButton.addTarget(self, action: #selector(pushPostController), for: .touchUpInside)
//        openPost.navigationButton.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
    }
    
    func configureView() {
        navigationItem.leftBarButtonItem = toBackBarButtonItem
        navigationItem.rightBarButtonItem = deleteButtonItem
        
        openPost.layer.zPosition = 1
        view.addSubview(openPost)
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            
            openPost.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: UIConstants.openPostTopInset),
            openPost.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: openPost.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: openPost.bottomAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
        ])
    }
}


extension AudioGuideViewController: AudioViewProtocol {
}
