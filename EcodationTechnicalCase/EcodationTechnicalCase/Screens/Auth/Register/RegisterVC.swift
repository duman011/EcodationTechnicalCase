//
//  RegisterVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

final class RegisterVC: UIViewController {

    //MARK: - Properties
    private let registerView      = RegisterView()
    
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
        
    }
    
    func loginTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
