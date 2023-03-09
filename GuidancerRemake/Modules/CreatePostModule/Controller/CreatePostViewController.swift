import UIKit

protocol CreatePostViewProtocol: AnyObject {
    var guideNameTextField: UITextField { get set }
    var guideDescriptionTextField: UITextView { get set }
    func showAlert()
}

final class CreatePostViewController: UIViewController, CreatePostViewProtocol {
    
    var presenter: CreatePostPresenterProtocol?
    
    private let titleLabel: GLabel = {
        let label = GLabel(text: "Create a new guide!",
                           font: .medium21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var guideNameTextField: UITextField = {
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
    
    var guideDescriptionTextField: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 0.8
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
        btn.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        return btn
    }()
    
    private lazy var mainSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [addPhoto, addVoice, selectLocation])
        sv.spacing = 10
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var miniSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [addMore, postButton])
        sv.spacing = 10
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [mainSV, miniSV])
        sv.spacing = 30
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Success", message: "Post is ready to be read", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertOK)
        present(alert, animated: true)
    }
    
    @objc func createPost() {
        presenter?.createPost()
    }
}

private extension CreatePostViewController {
    func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(profileImage)
        view.addSubview(guideNameTextField)
        view.addSubview(stackView)
        view.addSubview(guideDescriptionTextField)
        view.backgroundColor = .white
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            
            guideNameTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            guideNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            profileImage.leadingAnchor.constraint(equalTo: guideNameTextField.trailingAnchor, constant: 25),
            margin.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            
            guideDescriptionTextField.topAnchor.constraint(equalTo: guideNameTextField.bottomAnchor, constant: 15),
            guideDescriptionTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            margin.trailingAnchor.constraint(equalTo: guideDescriptionTextField.trailingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: guideDescriptionTextField.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            margin.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            margin.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            
            guideNameTextField.heightAnchor.constraint(equalToConstant: 50),
//            guideDescriptionTextField.heightAnchor.constraint(equalToConstant: 184),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}
