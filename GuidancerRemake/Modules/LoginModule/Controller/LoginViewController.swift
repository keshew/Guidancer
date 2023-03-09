//
//  LoginViewController.swift
//  Guidancer
//
//  Created by Vladimir Berezin on 04.11.22.
//

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
                                            font: .medium18)
    var passwordTextField = GTextField(imageName: "lock",
                                               placeholder: "Password",
                                               font: .medium18)
    private let titleLabel = GLabel(text: "Start exploring the world around!", font: .bold27)
    private let choiceLabel = UILabel()
    private let signInButton = GRectangleButton(title: "Sign In")
    private let appleButton = GRectangleButton(title: "Continue with Apple",
                                               image: UIImage(systemName: "applelogo"))
    private let googleButton = GRectangleButton(title: "Continue with Google",
                                                image: UIImage(systemName: "applelogo"))
    private let dontHaveAccountButton = HaveAccountButton(firstPart: "Don't have an account ? ",
                                                           secondPart: "Sign up here")
    private lazy var stack = UIStackView(arrangedSubviews: [emailTextField,
                                                    passwordTextField,
                                                    signInButton,
                                                    choiceLabel,
                                                    googleButton,
                                                    appleButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configSignInButton()
    }
    
    @objc func presentLogin() {
        presenter?.enterInAcc()
        tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    func pushProfileController() {
        let nav = UINavigationController(rootViewController: (presenter?.presentProfile())!)
        nav.modalPresentationStyle = .currentContext
        present(nav, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertOK)
        present(alert, animated: true)
    }

}

private extension LoginViewController {
    
    func configureUI() {
        view.backgroundColor = .white
        configLabel()
        configStackView()
        configDontHaveAccountButton()
    }
    
    func configLabel() {
        view.addSubview(titleLabel)
        titleLabel.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 20,
                              paddingLeft: 44,
                              paddinRight: 20)
        titleLabel.textAlignment = .left
        choiceLabel.text = "or"
        choiceLabel.font = .medium21
        choiceLabel.textAlignment = .center
    }
    
    func configStackView() {
        view.addSubview(stack)
        passwordTextField.textField.isSecureTextEntry = true
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
    }
    
    func configDontHaveAccountButton() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.addAnchors(left: view.leftAnchor,
                                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                         right: view.rightAnchor,
                                         paddingLeft: 40,
                                         paddinRight: 40)
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
