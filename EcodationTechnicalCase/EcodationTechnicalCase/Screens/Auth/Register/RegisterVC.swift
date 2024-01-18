//
//  RegisterVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

final class RegisterVC: UIViewController {

    //MARK: - Properties
    private let registerView   = RegisterView()
    private lazy var viewModel = RegisterViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.delegate = self
        configureNavBar()
       
    }
    // MARK: - Load View
    override func loadView() {
        super.loadView()
        view = registerView
    }

    // MARK: - UI Configuration
    private func configureNavBar() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}

//MARK: - RegisterInterface
extension RegisterVC : RegisterViewProtocol {
    func signUpTapped() {
        
         //Email & Password Validation
        guard let email = registerView.emailTextField.text,
              let password = registerView.passwordTextField.text,
              let rePassword = registerView.rePasswordTextField.text else{
             presentAlert(title: "Alert!", message: "Email, Password, rePassword ?", buttonTitle: "Ok")
             return
         }
         guard email.isValidEmail(email: email) else {
             presentAlert(title: "Alert!", message: "Email Invalid", buttonTitle: "Ok")
             return
         }
         
        guard password.count >= 6 else {
            presentAlert(title: "Alert!", message: "Password must be at least 6 characters", buttonTitle: "Ok")
            return
        }
        
        guard password.containsDigits(password) else {
            presentAlert(title: "Alert!", message: "Password must contain at least 1 digit", buttonTitle: "Ok")
            return
        }
        
        guard password.containsLowerCase(password) else {
            presentAlert(title: "Alert!", message: "Password must contain at least 1 lowercase character", buttonTitle: "Ok")
            return
        }
        
        guard password.containsUpperCase(password) else {
            presentAlert(title: "Alert!", message: "Password must contain at least 1 uppercase character", buttonTitle: "Ok")
            return
        }
     
        guard password == rePassword else {
            presentAlert(title: "Alert!", message: "Password and password repeat are not the same", buttonTitle: "Ok")
            return
        }
        
         guard password.isValidPassword(password: password) else {
             presentAlert(title: "Alert!", message: "Password Invalid", buttonTitle: "Ok")
             return
         }
    
        
        /// Validation kontrolü yapıldıktan sonra isteninlen forma uygunsa kayıt yapılacak
         viewModel.register(email: email,
                          password: password) { [weak self] in
             guard let self else { return }
             presentAlert(title: "Alert!", message: "Registration Successful 🥳", buttonTitle: "Ok")
             let mainTabBar = MainTabBarController()
             self.view.window?.rootViewController = mainTabBar
         }
    }
    
    func loginTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
