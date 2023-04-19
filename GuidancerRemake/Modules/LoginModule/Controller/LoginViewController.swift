import UIKit

protocol LoginViewProtocol: AnyObject {
    var emailTextField: GTextField { get set }
    var passwordTextField: GTextField { get set }
    func pushProfileController()
    func showAlert()
}

final class LoginViewController: UIViewController, LoginViewProtocol {
    
    var presenter: LoginPresenterProtocol?
    
    var emailTextField = GTextField(imageName: "user",
                                            placeholder: "Email",
                                            font: .medium21)
    
    private let titleLabel = GLabel(text: "Start exploring the world around!", font: .bold27)
    
    private let choiceLabel: GLabel = {
        let label = GLabel(text: "or", font: .medium21)
        label.textAlignment = .center
        return label
    }()
    
    var passwordTextField: GTextField = {
        let label = GTextField(imageName: "lock", placeholder: "Password", font: .medium21)
        label.textField.isSecureTextEntry = true
        return label
    }()
    
    private let signInButton = GRectangleButton(title: "Sign In")
    private let appleButton = GRectangleButton(title: "Continue with Apple",
                                               image: UIImage(systemName: "applelogo"))
    private let googleButton = GRectangleButton(title: "Continue with Google",
                                                image: UIImage(systemName: "applelogo"))
    private let dontHaveAccountButton = HaveAccountButton(firstPart: "Don't have an account ? ",
                                                           secondPart: "Sign up here")
    private lazy var stack = UIStackView(arrangedSubviews: [emailTextField,
                                                    passwordTextField])
    
    private lazy var stack2 = UIStackView(arrangedSubviews: [signInButton,
                                                    choiceLabel,
                                                    googleButton,
                                                    appleButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configSignInButton()

    }
    
    @objc func presentLogin() {
        presenter?.loginInAccount()
        tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    func pushProfileController() {
        guard let controller = presenter?.presentProfile() else { return }
        let navigtaionController = UINavigationController(rootViewController: controller)
        navigtaionController.modalPresentationStyle = .currentContext
        present(navigtaionController, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertOK)
        present(alert, animated: true)
    }

}

private extension LoginViewController {
    
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
            
            stack.heightAnchor.constraint(equalToConstant: 120),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    func configSignInButton() {
        signInButton.addTarget(self, action: #selector(presentLogin), for: .touchUpInside)
    }
}

enum HTTPStatusCodeGroup: Int {
    case Info = 100
    case Success = 200
    case Redirect = 300
    case Client = 400
    case Server = 500
    case Unknown = 999

    init(code: Int) {
        switch code {
            case 100...199: self = .Info
            case 200...299: self = .Success
            case 300...399: self = .Redirect
            case 400...499: self = .Client
            case 500...599: self = .Server
            default: self = .Unknown
        }
    }
}
