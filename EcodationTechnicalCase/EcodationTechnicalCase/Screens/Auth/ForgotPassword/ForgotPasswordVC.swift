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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordView.delegate = self
        configureNavBar()
    }
    
    override func loadView() {
        super.loadView()
        view = forgotPasswordView
    }
    
    private func configureNavBar() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
}

//MARK: - ForgotPasswordInterface
extension ForgotPasswordVC: ForgotPasswordViewProtocol {
    func forgotPasswordTapped() {
        
    }
    
    func loginTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

