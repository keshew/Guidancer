//
//  LoginViewController.swift
//  Guidancer
//
//  Created by Vladimir Berezin on 04.11.22.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    
}

final class LoginViewController: UIViewController, LoginViewProtocol {
    
    var presenter: LoginPresenterProtocol?
    
    private let emailTextField = GTextField(imageName: "user",
                                            placeholder: "Email",
                                            font: .medium18)
    private let passwordTextField = GTextField(imageName: "lock",
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
        //вход в акк to presenter
        guard let url = URL(string: "http://31.31.203.226:4444/auth/login") else { return }
        let parameters = ["email": emailTextField.textField.text, "password": passwordTextField.textField.text]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, respinse, error in
            if let respinse = respinse {
                print(respinse)
            }
            guard let data else { return }
            do {
                let jspn = try JSONSerialization.jsonObject(with: data, options: [])
                print(jspn)
            } catch {
                print(error)
            }
        }.resume()
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
