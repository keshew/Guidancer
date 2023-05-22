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
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()

    private var nicknameLabel = GLabel(font: .semiBold18,
                                  numberOfLines: 1)
    
    var followersLabel: GLabel = {
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
    
    private let titleOfTextLabel: GLabel = {
        let titleOfText = GLabel(font: .medium18)
        titleOfText.textColor = UIColor(named: "green")
        titleOfText.translatesAutoresizingMaskIntoConstraints = false
        return titleOfText
    }()
    
    private let mainTextLabel: GLabel = {
        let titleOfText = GLabel(font: .regular15)
        titleOfText.translatesAutoresizingMaskIntoConstraints = false
        return titleOfText
    }()
    
    lazy var playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "play"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return btn
    }()

    lazy var navigationButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "navigation"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var profileStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [profileImage, nicknameLabel])
        view.spacing = 15
        return view
    }()
    
    private lazy var likesStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [followersLabel, likeButton])
//        view.setContentCompressionResistancePriority(.defaultHigh + 2, for: .horizontal)
        view.spacing = 5
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [playButton, navigationButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 40
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [profileStackView, likesStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleOfTextLabel, mainTextLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
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
    
    }
    
    //to presenter
//    @objc func navigationTapped() {
//        let profile = UINavigationController(rootViewController: AudioGuideMapViewController())
//        profile.modalPresentationStyle = .fullScreen
//        self.window?.rootViewController?.present(profile, animated: true, completion: nil)
//    }
    
    func setupView(image: String?, nickname: String, firstTitle: String, text: String, numberOfLikes: Int) {
        profileImage.kf.setImage(with: URL(string: image ?? ""))
        self.nicknameLabel.text = nickname
        titleOfTextLabel.text = firstTitle
        mainTextLabel.text = text
        followersLabel.text = "\(numberOfLikes)"
    }
}

private extension PostView {
    func configureView() {
        backgroundColor = .white
        addSubview(mainStackView)
        addSubview(textStackView)
        addSubview(buttonStackView)
        addSubview(lineView)
       
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3),
            
            lineView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width / 2 - UIScreen.main.bounds.width / 6),
            
            mainStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 25),
            
            textStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 15),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: textStackView.trailingAnchor, constant: 25),
            
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width / 2 - 27),
            buttonStackView.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 5),
            bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: UIScreen.main.bounds.height / 20),
            
            playButton.heightAnchor.constraint(equalToConstant: 54),
            playButton.widthAnchor.constraint(equalToConstant: 54),
            
            titleOfTextLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
}
