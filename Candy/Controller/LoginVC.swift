//
//  ViewController.swift
//  Candy
//
//  Created by SimpuMind on 11/28/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var loginService: LoginService!
    
    lazy var loginLabel: UILabel = {
       let label = UILabel()
        label.text = "L O G I N"
        label.font = UIFont(name: "Avenir-Black", size: 14)
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var usernameTextFeild: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Avenir-Book", size: 14)
        textField.setPadding()
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordTextFeild: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Avenir-Book", size: 14)
        textField.setPadding()
        return textField
    }()
    
    lazy var loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 14) ?? UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), NSAttributedStringKey.underlineStyle: 1] as [NSAttributedStringKey : Any]
        let buttonTitleStr = NSMutableAttributedString(string: "New User? Register Here", attributes:attrs)
        button.setAttributedTitle(buttonTitleStr, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        constrainViews()
        registerButton.addTarget(self, action: #selector(presentRegistrationVC), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        loginService = LoginServiceDelegate(delegate: self, loginType: .LOGIN)
    }
    
    @objc func handleLogin(){
        guard let username = usernameTextFeild.text, let password = passwordTextFeild.text else {return}
        
        loginService.loginWith(username: username, password: password)
    }
    
    @objc func presentRegistrationVC(){
        let vc = RegisterVC()
        present(vc, animated: true, completion: nil)
    }
    
    func constrainViews(){
        [loginLabel, containerView]
            .forEach{view.addSubview($0)}
        
        [usernameLabel, usernameTextFeild, passwordLabel, passwordTextFeild, loginButton, registerButton]
            .forEach{containerView.addSubview($0)}
        
        loginLabel.topAnchor.align(to: view.topAnchor, offset: 44)
        loginLabel.widthAnchor.equal(to: 200)
        loginLabel.heightAnchor.equal(to: 15)
        loginLabel.centerXAnchor.align(to: view.centerXAnchor)
        
        containerView.widthAnchor.equal(to: 312)
        containerView.heightAnchor.equal(to: 316)
        containerView.centerXAnchor.align(to: view.centerXAnchor)
        containerView.centerYAnchor.align(to: view.centerYAnchor)
        
        usernameLabel.topAnchor.align(to: containerView.topAnchor)
        usernameLabel.leftAnchor.align(to: containerView.leftAnchor)
        usernameLabel.widthAnchor.equal(to: 312)
        usernameLabel.heightAnchor.equal(to: 13)
        
        usernameTextFeild.topAnchor.align(to: usernameLabel.bottomAnchor, offset: 10)
        usernameTextFeild.leftAnchor.align(to: containerView.leftAnchor)
        usernameTextFeild.rightAnchor.align(to: containerView.rightAnchor)
        usernameTextFeild.heightAnchor.equal(to: 51)
        
        passwordLabel.topAnchor.align(to: usernameTextFeild.bottomAnchor, offset: 15)
        passwordLabel.leftAnchor.align(to: containerView.leftAnchor)
        passwordLabel.widthAnchor.equal(to: 312)
        passwordLabel.heightAnchor.equal(to: 13)
        
        passwordTextFeild.topAnchor.align(to: passwordLabel.bottomAnchor, offset: 10)
        passwordTextFeild.leftAnchor.align(to: containerView.leftAnchor)
        passwordTextFeild.rightAnchor.align(to: containerView.rightAnchor)
        passwordTextFeild.heightAnchor.equal(to: 51)
        
        loginButton.topAnchor.align(to: passwordTextFeild.bottomAnchor, offset: 40)
        loginButton.leftAnchor.align(to: containerView.leftAnchor)
        loginButton.rightAnchor.align(to: containerView.rightAnchor)
        loginButton.heightAnchor.equal(to: 51)
        
        registerButton.topAnchor.align(to: loginButton.bottomAnchor, offset: 30)
        registerButton.leftAnchor.align(to: containerView.leftAnchor)
        registerButton.rightAnchor.align(to: containerView.rightAnchor)
        registerButton.heightAnchor.equal(to: 51)
    }

}

extension LoginVC: LoginActionService{
    
    func loginSuccessful(withUser: User) {
        //Login Successful
        showAlert(withTitle: "Login Success", message: "Welcome")
    }
    
    func handle(error: Error) {
        //Display Error
        showAlert(withTitle: "Login Error", message: error.localizedDescription)
    }
    
    
}

