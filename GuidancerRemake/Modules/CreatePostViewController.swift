import UIKit



final class CreatePostViewController: UIViewController {

    private let titleLabel = GLabel(text: "Create a new guide!",
                                    font: .medium21)
    
    private let guideNameTextField = UITextField()
    
    private let addImage = UIImageView(image: UIImage(named: "sight"))
    
    private let guideView = UIView()
    
    private let guideDescriptionTextView = UITextView()
    
    private let addPhotoButton = GWhiteRectangleButton(title: "Add photos")
    
    private let selectImage = UIImageView()
    
    private let selectSecond = UIImage()
    
    private let photoView = UIView()
    
    private let addVoiceButton = GWhiteRectangleButton(title: "Add voices")
    
    private let selectLocationButton = GWhiteRectangleButton(title: "Select location")
    
    private let emptyView = UIView()
    
    private let addLocation = GButton()
    
    
    
    private lazy var postButton: GButton = {
        let btn = GButton()
        btn.addTarget(self, action: #selector(presentLogin), for: .touchUpInside)
        return btn
    }()
    
    lazy var stack = UIStackView(arrangedSubviews: [titleLabel,
                                                    guideView,
                                                    guideDescriptionTextView,
                                                    addPhotoButton,
                                                    photoView,
                                                    addVoiceButton,
                                                    selectLocationButton,
                                                    emptyView,
                                                    addLocation,
                                                    postButton])
    
    lazy var scroll = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addSubview(scroll)
        configScrollView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        
    }
    
    @objc func presentLogin() {
        let controller = LoginViewController()
        present(controller, animated: true)
    }
    
    func configGuideView() {
        guideView.translatesAutoresizingMaskIntoConstraints = false
        guideView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        guideView.addSubview(guideNameTextField)
        guideNameTextField.setSize(width: 246 ,height: 44)
        guideNameTextField.centerYAnchor.constraint(equalTo: guideView.centerYAnchor).isActive = true
        guideNameTextField.backgroundColor = .white
        guideNameTextField.layer.cornerRadius = 16
        guideNameTextField.layer.borderWidth = 1.0
        guideNameTextField.placeholder = " Add guide name..."
        
        guideView.addSubview(addImage)
        addImage.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive = true
        addImage.setSize(width: 60, height: 60)
        addImage.layer.masksToBounds = true
        addImage.contentMode = .scaleAspectFill
        addImage.clipsToBounds = true
        addImage.layer.cornerRadius = 30
    }
    
    func configGuideDescriptionTextView() {
        guideDescriptionTextView.setSize(height: 184)
        guideDescriptionTextView.layer.cornerRadius = 16
        guideDescriptionTextView.layer.borderWidth = 1.0
    }
    
    func configPhotoView() {
//        photoView.translatesAutoresizingMaskIntoConstraints = false
//        photoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        photoView.backgroundColor = .blue
//        photoView.layer.cornerRadius = 16
//        photoView.layer.borderWidth = 1.0
        
        photoView.addSubview(selectImage)
        selectImage.setSize(width: 100)
        selectImage.backgroundColor = .blue
        selectImage.layer.cornerRadius = 16
        
    }
    
    func configAddLocation() {
        addLocation.setSize(width: 327, height: 49)
        addLocation.setTitle("Add more", for: .normal)
        addLocation.titleLabel?.font = .medium18
        addLocation.setTitleColor(.black, for: .normal)
        addLocation.layer.borderColor = UIColor.black.cgColor
        addLocation.layer.borderWidth = 1.0
        addLocation.layer.cornerRadius = 16
        addLocation.backgroundColor = .white
    }
    
    func configPost() {
        postButton.setSize(width: 327, height: 49)
        postButton.setTitle("Post", for: .normal)
        postButton.titleLabel?.font = .medium21
        postButton.backgroundColor = .black
        postButton.layer.cornerRadius = 16
    }
    
    func configStackView() {
        
        stack.axis = .vertical
        
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor)
        ])
        
        configGuideView()
        configGuideDescriptionTextView()
        configPhotoView()
        configAddLocation()
        configPost()
    }
    
    func configScrollView() {
        scroll.addSubview(stack)
        configStackView()
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
