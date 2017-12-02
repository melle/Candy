//
//  RegisterVC.swift
//  Candy
//
//  Created by SimpuMind on 12/1/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterVC: UIViewController {

    var loginService: LoginService!
    let realm = try! Realm()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "R E G I S T E R"
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
    
    lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "The password don't match"
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.textColor = #colorLiteral(red: 0.8240489364, green: 0.1265591383, blue: 0.1910214424, alpha: 1)
        label.textAlignment = .right
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var comfrimPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Comfirm Password"
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var comfirmPasswordTextFeild: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Avenir-Book", size: 14)
        textField.setPadding()
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 14) ?? UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), NSAttributedStringKey.underlineStyle: 1] as [NSAttributedStringKey : Any]
        let buttonTitleStr = NSMutableAttributedString(string: "Have an Account? Log In", attributes:attrs)
        button.setAttributedTitle(buttonTitleStr, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        constrainViews()
        
        comfirmPasswordTextFeild.delegate = self
        
        loginButton.addTarget(self, action: #selector(dismissToLogin(button:)), for: .touchUpInside)
        
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        loginService = LoginServiceDelegate(delegate: self, loginType: .REGISTER)
    }
    
    @objc func handleRegister(){
        guard let username = usernameTextFeild.text, let password = passwordTextFeild.text, let comfrimPassword = comfirmPasswordTextFeild.text else {return}
        if isComfirmedPassword(password: password, comfirmPassword: comfrimPassword){
            loginService.loginWith(username: username, password: password)
        }else{
            passwordErrorLabel.isHidden = false
        }
    }
    
    func isComfirmedPassword(password: String, comfirmPassword: String) -> Bool {
        if password == comfirmPassword{
            return true
        }else{
            return false
        }
    }
    
    @objc func dismissToLogin(button: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func constrainViews(){
        [loginLabel, containerView]
            .forEach{view.addSubview($0)}
        
        [usernameLabel, usernameTextFeild, passwordLabel, passwordTextFeild, passwordErrorLabel,
         comfrimPasswordLabel, comfirmPasswordTextFeild, registerButton, loginButton]
            .forEach{containerView.addSubview($0)}
        
        loginLabel.topAnchor.align(to: view.topAnchor, offset: 44)
        loginLabel.widthAnchor.equal(to: 200)
        loginLabel.heightAnchor.equal(to: 15)
        loginLabel.centerXAnchor.align(to: view.centerXAnchor)
        
        containerView.widthAnchor.equal(to: 312)
        containerView.heightAnchor.equal(to: 500)
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
        
        comfrimPasswordLabel.topAnchor.align(to: passwordTextFeild.bottomAnchor, offset: 15)
        comfrimPasswordLabel.leftAnchor.align(to: containerView.leftAnchor)
        comfrimPasswordLabel.widthAnchor.equal(to: 312)
        comfrimPasswordLabel.heightAnchor.equal(to: 13)
        
        passwordErrorLabel.topAnchor.align(to: passwordTextFeild.bottomAnchor, offset: 15)
        passwordErrorLabel.rightAnchor.align(to: containerView.rightAnchor)
        passwordErrorLabel.widthAnchor.equal(to: 312)
        passwordErrorLabel.heightAnchor.equal(to: 13)
        
        comfirmPasswordTextFeild.topAnchor.align(to: comfrimPasswordLabel.bottomAnchor, offset: 10)
        comfirmPasswordTextFeild.leftAnchor.align(to: containerView.leftAnchor)
        comfirmPasswordTextFeild.rightAnchor.align(to: containerView.rightAnchor)
        comfirmPasswordTextFeild.heightAnchor.equal(to: 51)
        
        registerButton.topAnchor.align(to: comfirmPasswordTextFeild.bottomAnchor, offset: 40)
        registerButton.leftAnchor.align(to: containerView.leftAnchor)
        registerButton.rightAnchor.align(to: containerView.rightAnchor)
        registerButton.heightAnchor.equal(to: 51)
        
        loginButton.topAnchor.align(to: registerButton.bottomAnchor, offset: 30)
        loginButton.leftAnchor.align(to: containerView.leftAnchor)
        loginButton.rightAnchor.align(to: containerView.rightAnchor)
        loginButton.heightAnchor.equal(to: 51)
    }
    
}

extension RegisterVC:  LoginActionService{
    
    func loginSuccessful(withUser: User) {
        //Login Successful
        try! realm.write {
            realm.add(withUser)
        }
    }
    
    func handle(error: Error) {
        //Display Error
        showAlert(withTitle: "Registration Error", message: error.localizedDescription)
    }
    
    
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == comfirmPasswordTextFeild {
            passwordErrorLabel.isHidden = true
        }
    }
}

