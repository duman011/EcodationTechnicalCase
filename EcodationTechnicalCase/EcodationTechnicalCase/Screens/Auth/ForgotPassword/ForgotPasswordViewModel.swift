//
//  forgotPasswordViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import Foundation

final class ForgotPasswordViewModel {
    
    private let  firebaseAuthManager: FirebaseAuthManagerProtocol
    
    init(firebaseAuthManager: FirebaseAuthManagerProtocol = FirebaseAuthManager.shared) {
        self.firebaseAuthManager = firebaseAuthManager
    }
    
    // MARK: - ForgotPassword
    func resetPassword(email: String, completion: @escaping (Bool, String) -> Void) {
        guard !email.isEmpty else {
            completion(false, "E-mail cannot be blank.")
            return
        }
        
        firebaseAuthManager.resetPassword(email: email) {
            completion(true, "Please check your e-mail to reset your password.")
        } onError: { error in
            completion(false, error)
        }
    }
}
