//
//  RxSwiftLoginViewModelTests.swift
//  RxSwiftLoginDemoTests
//
//  Created by MuRay Lin on 2018/11/6.
//  Copyright © 2018年 None. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import RxSwiftLoginDemo

class RxSwiftLoginViewModelTests: XCTestCase {

    let viewModel = RxSwiftLoginViewModel()
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testEmailIsValid() {
        let outputs = viewModel.outputs
        outputs.emailChecking.asDriver(onErrorJustReturn: false).drive(onNext: { (isValid) in
            XCTAssert(isValid == true)
        }).disposed(by: disposeBag)

        let emailInputObservable = scheduler.createHotObservable(
            [next(100, ("guest@guest.com"))])
        emailInputObservable.bind(to: viewModel.inputs.email).disposed(by: disposeBag)
        scheduler.start()

        viewModel.inputs.didTapLogin()
    }
    
    func testEmailIsNotValid() {
        let outputs = viewModel.outputs
        outputs.emailChecking.drive(onNext: { (isValid) in
            XCTAssert(isValid == false)
        }).disposed(by: disposeBag)

        let emailInputObservable = scheduler.createHotObservable(
            [next(100, ("guest@"))])
        emailInputObservable.bind(to: viewModel.inputs.email).disposed(by: disposeBag)
        scheduler.start()

        viewModel.inputs.didTapLogin()
    }

    func testPasswordIsValid() {
        let outputs = viewModel.outputs
        outputs.passwordChecking.asDriver(onErrorJustReturn: false).drive(onNext: { (isValid) in
            XCTAssert(isValid == true)
        }).disposed(by: disposeBag)

        let passwordInputObservable = scheduler.createHotObservable(
            [next(100, ("guest1234"))])
        passwordInputObservable.bind(to: viewModel.inputs.password).disposed(by: disposeBag)
        scheduler.start()
        viewModel.inputs.didTapLogin()
    }

    func testPasswordIsNotValid() {
        let outputs = viewModel.outputs
        outputs.passwordChecking.asDriver(onErrorJustReturn: false).drive(onNext: { (isValid) in
            XCTAssert(isValid == false)
        }).disposed(by: disposeBag)

        let passwordInputObservable = scheduler.createHotObservable(
            [next(100, ("guest"))])
        passwordInputObservable.bind(to: viewModel.inputs.password).disposed(by: disposeBag)
        scheduler.start()

        viewModel.inputs.didTapLogin()
    }

    func testLogin() {
        let outputs = viewModel.outputs
        outputs.login.drive(onNext: {
            XCTAssert(true)
        }).disposed(by: disposeBag)

        let emailInputObservable = scheduler.createHotObservable(
            [next(100, ("guest@guest.com"))])
        emailInputObservable.bind(to: viewModel.inputs.email).disposed(by: disposeBag)
        let passwordInputObservable = scheduler.createHotObservable(
            [next(200, ("guest1234"))])
        passwordInputObservable.bind(to: viewModel.inputs.password).disposed(by: disposeBag)
        scheduler.start()

        viewModel.inputs.didTapLogin()
    }
}
