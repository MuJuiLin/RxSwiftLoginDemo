//
//  LoginViewModelTests.swift
//  RxSwiftLoginDemoTests
//
//  Created by MuRay Lin on 2018/11/6.
//  Copyright © 2018年 None. All rights reserved.
//

import XCTest
@testable import RxSwiftLoginDemo

class LoginViewModelTests: XCTestCase {

    let viewModel = LoginViewModel()
    
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
        var outputs = viewModel.outputs
        outputs.emailCheckingCompletion = { isValid in
            XCTAssert(isValid == true)
        }
        viewModel.inputs.setEmail("guest@guest.com")
        viewModel.inputs.didTapLogin()
    }

    func testEmailIsNotValid() {
        var outputs = viewModel.outputs
        outputs.emailCheckingCompletion = { isValid in
            XCTAssert(isValid == false)
        }
        viewModel.inputs.setEmail("guest@")
        viewModel.inputs.didTapLogin()
    }

    func testPasswordIsValid() {
        var outputs = viewModel.outputs
        outputs.passwordCheckingCompletion = { isValid in
            XCTAssert(isValid == true)
        }
        viewModel.inputs.setPassword("guest1234")
        viewModel.inputs.didTapLogin()
    }
    
    func testPasswordIsNotValid() {
        var outputs = viewModel.outputs
        outputs.passwordCheckingCompletion = { isValid in
            XCTAssert(isValid == false)
        }
        viewModel.inputs.setPassword("guest")
        viewModel.inputs.didTapLogin()
    }

    func testLogin() {
        var outputs = viewModel.outputs
        outputs.loginCompletion = {
            XCTAssert(true)
        }
        viewModel.inputs.setEmail("guest@guest.com")
        viewModel.inputs.setPassword("guest1234")
        viewModel.inputs.didTapLogin()
    }
}
