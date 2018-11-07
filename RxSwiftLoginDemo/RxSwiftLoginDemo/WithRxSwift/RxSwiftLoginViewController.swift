//
//  RxSwiftLoginViewController.swift
//  RxSwiftLoginDemo
//
//  Created by MuRay Lin on 2018/11/6.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftLoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var llEmailError: UILabel!
    @IBOutlet weak var llPasswordError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!

    let viewModel = RxSwiftLoginViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        llEmailError.isHidden = true
        llPasswordError.isHidden = true
        bindViewModel()
    }
    
    func bindViewModel() {
        tfEmail.rx.text.bind(to: viewModel.inputs.email).disposed(by: disposeBag)
        tfPassword.rx.text.bind(to: viewModel.inputs.password).disposed(by: disposeBag)
        btnLogin.rx.tap.bind(onNext: viewModel.inputs.didTapLogin).disposed(by: disposeBag)

        viewModel.outputs.emailChecking.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] (isValid) in
            self?.llEmailError.isHidden = isValid
        }).disposed(by: disposeBag)
    
        viewModel.outputs.passwordChecking.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] (isValid) in
            self?.llPasswordError.isHidden = isValid
        }).disposed(by: disposeBag)
    
        viewModel.outputs.login.drive(onNext: {
                print("success")
        }).disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
