//
//  LoginViewModel.swift
//  RxSwiftLoginDemo
//
//  Created by MuRay Lin on 2018/11/6.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation

protocol LoginViewModelInputs {
    func setEmail(_ email: String?)
    func setPassword(_ password: String?)
    func didTapLogin()
}

protocol LoginViewModelOutputs {
    var emailCheckingCompletion: ((Bool) -> ())? { get set }
    var passwordCheckingCompletion: ((Bool) -> ())? { get set }
    var loginCompletion: (() -> ())? { get set }
}

class LoginViewModel: ViewModelBinding, LoginViewModelInputs, LoginViewModelOutputs {

    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    var emailCheckingCompletion: ((Bool) -> ())?
    var passwordCheckingCompletion:((Bool) -> ())?
    var loginCompletion: (() -> ())?

    private var emailString: String?
    private var passwordString: String?
    
    // MARK: - LoginViewModelInputs
    func setEmail(_ email: String?) {
        emailString = email
    }

    func setPassword(_ password: String?) {
        passwordString = password
    }

    func didTapLogin() {
        let emailIsValid = isValidEmail(emailString)
        let passwordIsValid = isValidPassword(passwordString)
        outputs.emailCheckingCompletion?(emailIsValid)
        outputs.passwordCheckingCompletion?(passwordIsValid)
        if emailIsValid && passwordIsValid {
            loginCompletion?()
        }
    }
}

extension LoginViewModel {
    func isValidEmail(_ email: String?) -> Bool {
        guard let anEmail = email else { return false }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: anEmail)
    }

    func isValidPassword(_ password: String?) -> Bool  {
        guard let aPassword = password else { return false }

        return aPassword.count > 8
    }
}
