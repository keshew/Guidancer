import UIKit

protocol RegisterViewProtocol: AnyObject {
    var emailTextField: GTextField { get set }
    var passwordTextField: GTextField { get set }
    var nicknameTextField: GTextField { get set }
    func alertOK()
    func alertError()
}

class RegisterViewController: UIViewController {
    
    var presenter: RegisterPresenterProtocol?

    var emailTextField = GTextField(imageName: "user",
                                            placeholder: "Enter e-mail address",
                                            font: .medium21)
    
    private let titleLabel = GLabel(text: "Start exploring the world around!", font: .bold27, numberOfLines: 0)
    
    private let choiceLabel: GLabel = {
        let label = GLabel(text: "or", font: .medium21)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttomItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(dissmissVC))
        item.tintColor = .black
        return item
    }()
    
    var passwordTextField: GTextField = {
        let label = GTextField(imageName: "lock", placeholder: "Create a password", font: .medium21)
        label.textField.isSecureTextEntry = true
        return label
    }()
    
    var nicknameTextField: GTextField = {
        let label = GTextField(systemImageName: "at", placeholder: "Choose your nickname", font: .medium21)
        return label
    }()
    
    
    private lazy var signInButton: GRectangleButton = {
        let btn = GRectangleButton(title: "Sign In")
        btn.addTarget(self, action: #selector(registerProfile), for: .touchUpInside)
        return  btn
    }()
    private let appleButton = GRectangleButton(title: "Continue with Apple",
                                               image: UIImage(systemName: "applelogo"))
    
    private let googleButton = GRectangleButton(title: "Continue with Google",
                                                image: UIImage(systemName: "applelogo"))
    
    private lazy var dontHaveAccountButton: HaveAccountButton = {
        let btn = HaveAccountButton(firstPart: "Already have an account ? ",
                                    secondPart: "Login here")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(dissmissVC), for: .touchUpInside)
        return btn
    }()
    private lazy var stack = UIStackView(arrangedSubviews: [emailTextField,
                                                            passwordTextField,
                                                            nicknameTextField])
    
    private lazy var stack2 = UIStackView(arrangedSubviews: [signInButton,
                                                    choiceLabel,
                                                    googleButton,
                                                    appleButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBarButtonItem()
        
    }
    
    func alertOK() {
        let alert = UIAlertController(title: "Sucsess", message: "Well done! Please login in your account", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertOK)
        present(alert, animated: true)
    }
    
    func alertError() {
        let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertOK)
        present(alert, animated: true)
    }

}

extension RegisterViewController: RegisterViewProtocol {
}

private extension RegisterViewController {
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(stack)
        view.addSubview(stack2)
        view.addSubview(dontHaveAccountButton)
        
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack2.axis = .vertical
        stack2.distribution = .fillProportionally
        stack2.spacing = 15
        stack2.translatesAutoresizingMaskIntoConstraints = false
        
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            margin.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIScreen.main.bounds.height / 15),
            stack.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            margin.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            stack2.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: UIScreen.main.bounds.height / 15),
            stack2.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            margin.trailingAnchor.constraint(equalTo: stack2.trailingAnchor),
            
            
            dontHaveAccountButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            margin.trailingAnchor.constraint(equalTo: dontHaveAccountButton.trailingAnchor),
            margin.bottomAnchor.constraint(equalTo: dontHaveAccountButton.bottomAnchor, constant: 10),
            
            stack.heightAnchor.constraint(equalToConstant: 180),
            googleButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 19),
            appleButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 19),
//            titleLabel.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = buttomItem
    }
    
    @objc func dissmissVC() {
        dismiss(animated: true)
    }
    
    @objc func registerProfile() {
        presenter?.registerAccount()
    }
}
