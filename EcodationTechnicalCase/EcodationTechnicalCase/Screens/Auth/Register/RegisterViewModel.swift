//
//  RegisterViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import Foundation

final class RegisterViewModel {
    private let  firebaseAuthManager: FirebaseAuthManagerProtocol
    
    init(firebaseAuthManager: FirebaseAuthManagerProtocol = FirebaseAuthManager.shared) {
        self.firebaseAuthManager = firebaseAuthManager
    }
    
    // MARK: - Register
    func register(email: String, password: String, completion: @escaping () -> Void) {
        firebaseAuthManager.register(email: email,
                                     password: password) {
            completion()
        } onError: { error in
            print(error)
        }

    }
}
