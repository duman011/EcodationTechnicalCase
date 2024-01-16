//
//  LoginViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import FirebaseAuth

final class LoginViewModel {
    //MARK: - Lifecycle
    private let  firebaseAuthManager: FirebaseAuthManagerProtocol
    
    //MARK: - Initializers
    init(firebaseAuthManager: FirebaseAuthManagerProtocol = FirebaseAuthManager.shared) {
        self.firebaseAuthManager = firebaseAuthManager
    }
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping () -> Void) {
        firebaseAuthManager.signIn(email: email, password: password) {
            completion()
        } onError: { error in
            print(error.localizedDescription)
        }
    }
    
    func signInGoogle(credential: AuthCredential, email: String, completion: @escaping () -> Void) {
        firebaseAuthManager.signInWithCredential(credential: credential, email: email) {
            completion()
        } onError: { error in
            print(error)
        }
    }
}
