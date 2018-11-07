//
//  RxSwiftLoginViewModel.swift
//  RxSwiftLoginDemo
//
//  Created by MuRay Lin on 2018/11/6.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RxSwiftLoginViewModelInputs {
    var email: BehaviorRelay<String?> { get }
    var password: BehaviorRelay<String?> { get }
    func didTapLogin()
}

protocol RxSwiftLoginViewModelOutputs {
    var emailChecking: Driver<Bool> { get }
    var passwordChecking: Driver<Bool> { get }
    var login: Driver<Void> { get }
}

class RxSwiftLoginViewModel: ViewModelBinding, RxSwiftLoginViewModelInputs, RxSwiftLoginViewModelOutputs {
    var inputs: RxSwiftLoginViewModelInputs { return self }
    var outputs: RxSwiftLoginViewModelOutputs { return self }
    
    var email: BehaviorRelay<String?>
    var password: BehaviorRelay<String?>

    var emailChecking: Driver<Bool>
    var passwordChecking: Driver<Bool>
    var login: Driver<Void>
    
    private let loginSubject: PublishSubject<Void> = PublishSubject()
    private let emailCheckingSubject: PublishSubject<Bool> = PublishSubject()
    private let passwordCheckingSubject: PublishSubject<Bool> = PublishSubject()

    init() {
        email = BehaviorRelay(value: nil)
        password = BehaviorRelay(value: nil)
        login =  loginSubject.asDriver(onErrorJustReturn: ())
        emailChecking = emailCheckingSubject.asDriver(onErrorJustReturn: false)
        passwordChecking = passwordCheckingSubject.asDriver(onErrorJustReturn: false)
    }
    
    func didTapLogin() {
        let emailIsValid = isValidEmail(email.value)
        let passwordIsValid = isValidPassword(password.value)
        emailCheckingSubject.onNext(emailIsValid)
        passwordCheckingSubject.onNext(passwordIsValid)
        if emailIsValid && passwordIsValid {
            loginSubject.onNext(())
        }
    }
}

extension RxSwiftLoginViewModel {
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
