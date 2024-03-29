//
//  LoginVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn



final class LoginVC: UIViewController {
    //MARK: - Properties
    private let loginView      = LoginView()
    private lazy var viewModel = LoginViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
    }
    
    // MARK: - Load View
    override func loadView() {
        super.loadView()
        view = loginView
    }
}

//MARK: - HomeViewInterface
// LoginViewProtocol protokolünü uygulayan metotlar.
extension LoginVC: LoginViewProtocol {
    
    func forgotPasswordTapped() {
        let vc = ForgotPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loginTapped() {
        //Email & Password Validation
        
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else{
            presentAlert(title: "Alert!", message: "Email and Password ?", buttonTitle: "Ok")
            return
        }
        
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Alert!", message: "Email Invalid", buttonTitle: "Ok")
            return
        }
            
        /// Validation kontrolü yapıldıktan sonra isteninlen forma uygunsa login yapılacak
        viewModel.login(email: email, password: password) { [weak self] in
            guard let self else { return }
            presentAlert(title: "Alert!", message: "Entry Successful 🥳", buttonTitle: "Ok")
            let mainTabBar = MainTabBarController()
            self.view.window?.rootViewController = mainTabBar
        }
    }
    
    // Google ile giriş butonuna tıkladığında çağrılan metot.
    func googleLoginTapped() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let userEmail = result?.user,
                  let idToken = userEmail.idToken?.tokenString,
                    let email: String = userEmail.profile?.email
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: userEmail.accessToken.tokenString)
            viewModel.signInGoogle(credential: credential,email: email) {[weak self] in
                guard let self else { return }
                presentAlert(title: "Alert!", message: "Registration Successful 🥳", buttonTitle: "Ok")
                let mainTabBar = MainTabBarController()
                self.view.window?.rootViewController = mainTabBar
            }
        }
    }
    
    func signUpTapped() {
        let vc = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
