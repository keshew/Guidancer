import UIKit
import Kingfisher

class ProfileView: UIView {
    
    fileprivate enum UIConstants {
        static let viewCornerRadius: CGFloat = 25
        static let imageCornerRadius: CGFloat = 25
        static let stackViewSpacing: CGFloat = 15
        static let backgroundImageHeight: CGFloat = 170
        static let imageOfProfileSize: CGFloat = 100
        static let secondViewTopInset: CGFloat = -20
        static let imageOfProfileTopInset: CGFloat = -50
        static let nicknameTopInset: CGFloat = 5
        static let nicknameBottomInset: CGFloat = 5
        static let routesInset: CGFloat = 10
    }
    
    private var backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "mosow"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        return image
    }()
    
    private let secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        return view
    }()
    
    private var imageOfProfile: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = UIConstants.imageCornerRadius
        image.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        return image
    }()
    
    private var nickname = GLabel(font: .semiBold18)
    
    lazy var followersButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "person"), for: .normal)
        btn.addTarget(self, action: #selector(priv), for: .touchUpInside)
        btn.tintColor = .black
        return btn
    }()
    
    @objc func priv() {
        
    }

    private let commentButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private var followers: GLabel = {
        let label = GLabel(text: "150K", font: .regular11)
        label.textAlignment = .center
        return label
    }()
    
    private var likes: GLabel = {
        let label = GLabel(text: "3M",font: .regular11)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var likesSV = UIStackView(arrangedSubviews: [followersButton, followers])
    private lazy var subs = UIStackView(arrangedSubviews: [commentButton, likes])

    private lazy var main: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [likesSV, subs])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = UIConstants.stackViewSpacing
        return sv
    }()

    private let routes = GLabel(text: "Routes", font: .semiBold16)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserInforamtion(image: String?, nickname: String, numberOfLikes: Int?, numberOfFollowers: Int?) {
        guard let image = image else { return }
        imageOfProfile.kf.setImage(with: URL(string: image))
        self.nickname.text = nickname
        self.likes.text = "\(numberOfLikes ?? 0)"
        self.followers.text = "\(numberOfFollowers ?? 0)"
    }
}

private extension ProfileView {
    func configureView() {
        addSubview(backgroundImage)
        addSubview(secondView)
        addSubview(imageOfProfile)
        secondView.addSubview(nickname)
        secondView.addSubview(main)
        secondView.addSubview(routes)

        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalToConstant: UIConstants.backgroundImageHeight),
            imageOfProfile.heightAnchor.constraint(equalToConstant: UIConstants.imageOfProfileSize),
            imageOfProfile.widthAnchor.constraint(equalToConstant: UIConstants.imageOfProfileSize),

            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            secondView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: UIConstants.secondViewTopInset),
            
            secondView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: secondView.trailingAnchor),
            bottomAnchor.constraint(equalTo: secondView.bottomAnchor),
            
            imageOfProfile.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            imageOfProfile.topAnchor.constraint(equalTo: secondView.topAnchor, constant: UIConstants.imageOfProfileTopInset),
            
            nickname.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            nickname.topAnchor.constraint(equalTo: imageOfProfile.bottomAnchor, constant: UIConstants.nicknameTopInset),
            
            main.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            main.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: UIConstants.nicknameBottomInset),
            
            routes.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: UIConstants.routesInset),
            secondView.bottomAnchor.constraint(equalTo: routes.bottomAnchor, constant: UIConstants.routesInset)
        ])
    }
}
