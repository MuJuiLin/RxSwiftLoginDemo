//
//  ViewController.swift
//  RxSwiftLoginDemo
//
//  Created by MuRay Lin on 2018/11/6.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var llEmailError: UILabel!
    @IBOutlet weak var llPasswordError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBAction func inputEmail(_ sender: UITextField) {
        viewModel.inputs.setEmail(sender.text)
    }
    @IBAction func inputPassword(_ sender: UITextField) {
        viewModel.inputs.setPassword(sender.text)
    }
    @IBAction func login(_ sender: Any) {
        viewModel.inputs.didTapLogin()
    }
    
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        llEmailError.isHidden = true
        llPasswordError.isHidden = true
        bindViewModel()
    }

    func bindViewModel() {
        var outputs = viewModel.outputs
        outputs.emailCheckingCompletion = { [weak self] (isValid) in
            self?.llEmailError.isHidden = isValid
        }
        outputs.passwordCheckingCompletion = { [weak self] (isValid) in
            self?.llPasswordError.isHidden = isValid
        }
        outputs.loginCompletion = {
            print("success")
        }
    }
}

