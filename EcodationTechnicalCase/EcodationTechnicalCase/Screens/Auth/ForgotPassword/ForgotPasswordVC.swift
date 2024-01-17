//
//  ForgotPasswordVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

final class ForgotPasswordVC: UIViewController {
    
    //MARK: - Properties
    private let forgotPasswordView = ForgotPasswordView()
    private let viewModel = ForgotPasswordViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordView.delegate = self
        configureNavBar()
    }
    
    // MARK: - Load View
    override func loadView() {
        super.loadView()
        view = forgotPasswordView
    }
    
    // MARK: - Configuration NavBar
    private func configureNavBar() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
    }  
}

//MARK: - ForgotPasswordViewInterface
extension ForgotPasswordVC: ForgotPasswordViewProtocol {
    func forgotPasswordTapped() {
        
        guard let email = forgotPasswordView.emailTextField.text else {
            return
        }
        
       //Email Validation
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Alert!", message: "Invalide Email Address", buttonTitle: "Ok")
            return
        }
        
        /// Validation kontrolü yapıldıktan sonra isteninlen forma uygunsa maile firebase aracılıgı ile kod gönderilecek yapılacak
        viewModel.resetPassword(email: email) { [weak self] success, message in
            guard let self else { return }
            if success {
                presentAlert(title: "Alert!", message: message, buttonTitle: "Ok")
                navigationController?.popToRootViewController(animated: true)
            } else {
                presentAlert(title: "Alert!", message: message, buttonTitle: "Ok")
            }
        }
    }
    
    func loginTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

