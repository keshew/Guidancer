import UIKit

protocol CreatePostViewProtocol: AnyObject {
}

final class CreatePostViewController: UIViewController, CreatePostViewProtocol {
    
    var presenter: CreatePostPresenterProtocol?
    
    private let titleLabel: GLabel = {
        let label = GLabel(text: "Create a new guide!",
                           font: .medium21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let guideNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Add location name..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 0.8
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        return tf
    }()
    
    private let guideDescriptionTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Add location description..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 15
        tf.contentVerticalAlignment = .top
        tf.layer.borderWidth = 0.8
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 10, 0)
        return tf
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Image")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        return image
    }()
    
    private let addPhoto = GWhiteRectangleButton(title: "Add photo")
    private let addVoice = GWhiteRectangleButton(title: "Add voice")
    private let selectLocation = GWhiteRectangleButton(title: "Select location")
    private let addMore = GWhiteRectangleButton(title: "Add more")
    
    private lazy var postButton: GWhiteRectangleButton = {
        let btn = GWhiteRectangleButton(title: "Post", backColor: .black, tintColor: .white)
        btn.addTarget(self, action: #selector(presentLogin), for: .touchUpInside)
        return btn
    }()
    
    private lazy var mainSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [guideDescriptionTextField, addPhoto, addVoice, selectLocation])
        sv.spacing = 15
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var miniSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [addMore, postButton])
        sv.spacing = 15
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    @objc func presentLogin() {
        let controller = LoginViewController()
        present(controller, animated: true)
    }
}

private extension CreatePostViewController {
    func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(profileImage)
        view.addSubview(guideNameTextField)
        view.addSubview(mainSV)
        view.addSubview(miniSV)
        view.backgroundColor = .white
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            
            titleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10),
            
            guideNameTextField.heightAnchor.constraint(equalToConstant: 50),
            guideNameTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            guideNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            profileImage.leadingAnchor.constraint(equalTo: guideNameTextField.trailingAnchor, constant: 25),
            margin.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            guideDescriptionTextField.heightAnchor.constraint(equalToConstant: 170),
            mainSV.topAnchor.constraint(equalTo: guideNameTextField.bottomAnchor, constant: 20),
            mainSV.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            margin.trailingAnchor.constraint(equalTo: mainSV.trailingAnchor, constant: 10),
            
            margin.bottomAnchor.constraint(equalTo: miniSV.bottomAnchor, constant: 20),
            miniSV.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            margin.trailingAnchor.constraint(equalTo: miniSV.trailingAnchor, constant: 10),

            addPhoto.heightAnchor.constraint(equalToConstant: 50),
            addVoice.heightAnchor.constraint(equalToConstant: 50),
            addMore.heightAnchor.constraint(equalToConstant: 50),
            postButton.heightAnchor.constraint(equalToConstant: 50),
            selectLocation.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
