import UIKit
import MediaPlayer

class PostView: UIView {
    static var shared = PostView()
    
    var player: AVPlayer!
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkGray")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageOfProfile: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        return image
    }()

    private var nickname = GLabel(font: .semiBold18,
                                  numberOfLines: 1)
    
    private var followers: GLabel = {
        let label = GLabel(text: "2.2K", font: .regular14)
        label.textAlignment = .center
        return label
    }()
    
    private let likeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        btn.tintColor = .black
        return btn
    }()
    
    private let titleOfText: GLabel = {
        let titleOfText = GLabel(font: .medium18)
        titleOfText.textColor = UIColor(named: "green")
        titleOfText.translatesAutoresizingMaskIntoConstraints = false
     
        return titleOfText
    }()
    
    private var mainText = GLabel(font: .regular15)
    
    lazy var playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "play"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var navigationButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "navigation"), for: .normal)
        btn.addTarget(self, action: #selector(navigationTapped), for: .touchUpInside)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var stackViewOfProfile: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageOfProfile, nickname])
        view.spacing = 15
        return view
    }()
    
    private lazy var likesSV: UIStackView = {
        let view = UIStackView(arrangedSubviews: [followers, likeButton])
        view.spacing = 5
        return view
    }()
    
    private lazy var buttonSV: UIStackView = {
        let view = UIStackView(arrangedSubviews: [playButton, navigationButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 40
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [stackViewOfProfile, likesSV])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 70
        return view
    }()
    
    private lazy var textStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleOfText, mainText])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    //to preseneter
    @objc func playTapped() {
        let navControl = UINavigationController()
        let builder = ModuleBuilder()
        let router = PostRouter(navigationController: navControl, builder: builder)
        let post = builder.buildPost(router: router)
           if let sheet = post.sheetPresentationController {
               sheet.detents = [.large()]
           }
        self.window?.rootViewController?.present(post, animated: true, completion: nil)
    }
    
    //to presenter
    @objc func navigationTapped() {
        let profile = UINavigationController(rootViewController: AudioGuideMapViewController())
        profile.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(profile, animated: true, completion: nil)
    }
    
    func setupView(image: String?, nickname: String, firstTitle: String, text: String) {
        imageOfProfile.kf.setImage(with: URL(string: image ?? ""))
        self.nickname.text = nickname
        titleOfText.text = firstTitle
        mainText.text = text
    }
}

private extension PostView {
    func configureView() {
        backgroundColor = .white
        addSubview(mainStack)
        addSubview(textStackView)
        addSubview(buttonSV)
        addSubview(lineView)
       
        NSLayoutConstraint.activate([
            imageOfProfile.heightAnchor.constraint(equalToConstant: 50),
            imageOfProfile.widthAnchor.constraint(equalToConstant: 50),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3),
            
            lineView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width / 2 - UIScreen.main.bounds.width / 6),
            
            mainStack.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: 25),
            
            textStackView.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 20),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: textStackView.trailingAnchor, constant: 25),
            
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width / 2 - 27),
            buttonSV.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 50),
            bottomAnchor.constraint(equalTo: buttonSV.bottomAnchor, constant: 70),
            playButton.heightAnchor.constraint(equalToConstant: 54),
            playButton.widthAnchor.constraint(equalToConstant: 54),
        ])
        
    }
}
