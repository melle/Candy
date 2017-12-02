//
//  LoginService.swift
//  Candy
//
//  Created by SimpuMind on 12/1/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation
import RealmSwift

enum LoginType {
    case LOGIN
    case REGISTER
}

enum LoginServiceError: LocalizedError {
    case invalidCredentials
    
    var errorDescription: String? {
        var errorString:String? = nil
        switch self {
        case .invalidCredentials:
            errorString = "The user credentials are invalid"
        }
        return errorString
    }
}

protocol LoginService {
    var delegate: LoginActionService {get}
    func loginWith(username: String?, password: String?)
}

protocol LoginActionService {
    func loginSuccessful(withUser: User)
    func handle(error: Error)
}

class LoginServiceDelegate: LoginService{
    
    var delegate: LoginActionService
    var loginType: LoginType
    
    init(delegate: LoginActionService, loginType: LoginType) {
        self.delegate = delegate
        self.loginType = loginType
    }
    
    func loginWith(username: String?, password: String?) {
        
        let result = validate(userName: username?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", password: password?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", loginType: loginType)
        switch result {
        case .failure(let error):
            delegate.handle(error: error)
            return
        case .success(_):
            // save user to Realm
            break
        }
        
        guard let username = username else {
            delegate.handle(error: LoginFormValidationError.invalidUsernameLength)
            return
        }
        
        guard let password = password else {
            delegate.handle(error: LoginFormValidationError.invalidPasswordLength)
            return
        }
        
        let user = User()
        user.username = username
        user.password = password
        delegate.loginSuccessful(withUser: user)
    }
    
    func validate(userName username: String, password: String, loginType: LoginType) -> Result<Bool> {
        guard username.count >= 2 && username.count <= 10 else {
            return Result.failure(LoginFormValidationError.invalidUsernameLength)
        }
        
        guard password.count > 2 else {
            return Result.failure(LoginFormValidationError.invalidPasswordLength)
        }
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: password)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: password)
        
        guard capitalresult && numberresult else {
            return Result.failure(LoginFormValidationError.invalidPasswordCharacters)
        }
        
        let exist = isUserExist(username: username)
        switch loginType{
        case .LOGIN:
            if exist.0 && exist.1 == password{
                return .success(true)
            }else {
                return Result.failure(LoginFormValidationError.userNotExisting)
            }
        case .REGISTER:
            if exist.0{
                return Result.failure(LoginFormValidationError.userExist)
            }else{
                return .success(true)
            }
        }
    }
    func isUserExist(username: String) -> (Bool, String?) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "username CONTAINS [c] %@", username)
        guard let user = realm.objects(User.self).filter(predicate).first else {
            return (true, nil)
        }
        return (true, user.password)
    }
}
