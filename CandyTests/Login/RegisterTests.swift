//
//  RegisterTests.swift
//  CandyTests
//
//  Created by SimpuMind on 12/2/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import XCTest
@testable import Candy

class RegisterTests: XCTestCase {
    
    let sut = RegisterVC()
    
    override func setUp() {
        super.setUp()
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIfTheTwoPasswordFeildAreTheSame(){
        let first =  "Lawal3"
        let second = "Lawal33"
        let comfirmed = sut.isComfirmedPassword(password: first, comfirmPassword: second)
        XCTAssertFalse(comfirmed)
    }
    
    func testInvalidUsernameLength(){
        let actionDelegate = FakeLoginActionService()
        sut.usernameTextFeild.text = "p"
        sut.loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        sut.loginButton.sendActions(for: .touchUpInside)
        
        guard let receivedError = actionDelegate.error as? LoginFormValidationError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: actionDelegate.error))")
            return
        }
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handleError is not called.")
        XCTAssert(receivedError == LoginFormValidationError.invalidUsernameLength, "The function handleError is called but the error received as the argument in the function is wrong, Expected the error of type \(LoginFormValidationError.invalidUsernameLength) but got \(receivedError)")
    }
    
    func testInvalidPasswordLength(){
        
        let actionDelegate = FakeLoginActionService()
        
        sut.usernameTextFeild.text = "dolapo"
        sut.passwordTextFeild.text = "po"
        sut.loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        sut.loginButton.sendActions(for: .touchUpInside)
        guard let receivedError = actionDelegate.error as? LoginFormValidationError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: actionDelegate.error))")
            return
        }
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handleError is not called.")
        XCTAssert(receivedError == LoginFormValidationError.invalidPasswordLength, "The function handleError is called but the error received as the argument in the function is wrong, Expected the error of type \(LoginFormValidationError.invalidPasswordLength) but got \(receivedError)")
    }
    
    func testInvalidPasswordCharacters() {
        
        let actionDelegate = FakeLoginActionService()
        
        sut.usernameTextFeild.text = "hafees"
        sut.passwordTextFeild.text = "lawal3"
        sut.loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        sut.loginButton.sendActions(for: .touchUpInside)
        guard let receivedError = actionDelegate.error as? LoginFormValidationError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: actionDelegate.error))")
            return
        }
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handleError is not called.")
        XCTAssert(receivedError == LoginFormValidationError.invalidPasswordCharacters, "The function handleError is called but the error received as the argument in the function is wrong, Expected the error of type \(LoginFormValidationError.invalidPasswordCharacters) but got \(receivedError)")
    }
    
    func testSuccessfullValidation(){
        let actionDelegate = FakeLoginActionService()
        let loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        loginService.loginWith(username: "hafees", password: "Lawal3")
        
        if !actionDelegate.isLoginSuccessFullCalled{
            XCTFail("Function validate returned error whereas it was expected to succeed. The error is \(String(describing: actionDelegate.error?.localizedDescription))")
        }
        XCTAssertTrue(actionDelegate.isLoginSuccessFullCalled, "The function loginsuccessfull is not called.")
    }
    
    func testIfUsernameDoesNotExist(){
        let actionDelegate = FakeLoginActionService()
        
        let loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        loginService.loginWith(username: "hafeees", password: "Lawal3")
        
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handle error is not called.")
        
        guard let loginFormError = actionDelegate.error as? LoginFormValidationError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: actionDelegate.error))")
            return
        }
        
        
        
        XCTAssert(loginFormError.localizedDescription == LoginFormValidationError.userNotExisting.localizedDescription, "Expected validation error of type userNotExisting but got \(loginFormError)")
    }
    
    func testUsernameLengthValidation() {
        
        let actionDelegate = FakeLoginActionService()
        
        let loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        loginService.loginWith(username: "p", password: "Lawal3")
        
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handle error is not called.")
        
        guard let loginFormError = actionDelegate.error as? LoginFormValidationError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: actionDelegate.error))")
            return
        }
        
        XCTAssert(loginFormError == LoginFormValidationError.invalidUsernameLength, "Expected validation error of type invalidUsernameLength but got \(loginFormError)")
        
    }
    
    func testPasswordLengthValidation() {
        
        let actionDelegate = FakeLoginActionService()
        
        let loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        loginService.loginWith(username: "hafees", password: "a")
        
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handle error is not called.")
        
        guard let loginFormError = actionDelegate.error as? LoginFormValidationError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: actionDelegate.error))")
            return
        }
        
        XCTAssert(loginFormError == LoginFormValidationError.invalidPasswordLength, "Expected validation error of type invalidUsernameLength but got \(loginFormError)")
        
    }
    
    func testPasswordCharacterValidation() {
        
        let actionDelegate = FakeLoginActionService()
        
        let loginService = LoginServiceDelegate(delegate: actionDelegate, loginType: .REGISTER)
        loginService.loginWith(username: "hafees", password: "lawal")
        
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handle error is not called.")
        
        guard let loginFormError = actionDelegate.error as? LoginFormValidationError else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: actionDelegate.error))")
            return
        }
        
        XCTAssert(loginFormError == LoginFormValidationError.invalidPasswordCharacters, "Expected validation error of type invalidUsernameLength but got \(loginFormError)")
        
    }
    
    
    class FakeLoginActionService: LoginActionService {
        
        var isLoginSuccessFullCalled = false
        var isHandleErrorCalled = false
        var error: Error? = nil
        
        func loginSuccessful(withUser user: User) {
            isLoginSuccessFullCalled = true
        }
        
        func handle(error: Error) {
            isHandleErrorCalled = true
            self.error = error
        }
    }
}

