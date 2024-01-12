//
//  LoginVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import UIKit

final class LoginVC: UIViewController {
    //MARK: - Properties
    private let loginView      = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
}
