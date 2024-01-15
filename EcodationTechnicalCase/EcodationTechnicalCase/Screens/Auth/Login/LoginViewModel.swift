//
//  LoginViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import FirebaseAuth

final class LoginViewModel {
    private let  firebaseAuthManager: FirebaseAuthManagerProtocol
    
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
    
    func signInGoogle(credential: AuthCredential, username: String, completion: @escaping () -> Void) {
        firebaseAuthManager.signInWithCredential(credential: credential, username: username) {
            completion()
        } onError: { error in
            print(error)
        }
    }
}
