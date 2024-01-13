//
//  FirebaseAuthManager.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import FirebaseAuth
import FirebaseFirestore

final class FirebaseAuthManager {
    func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error { onError(error) }
            guard let result else { return }
            ApplicationVariables.currentUserID = result.user.uid
            onSuccess()
        }
    }
    
    func register(userName: String, email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error { onError(error) }
            
            guard let result else { return }
            
            let ref = Firestore.firestore().collection("UsersInfo").document(result.user.uid)
            
            let data = [
                "userName" : userName
            ] as! [String : Any]
            
            ApplicationVariables.currentUserID = result.user.uid
            ref.setData(data) { error in
                if let error { onError(error) }
                onSuccess()
            }
        }
    }
    
    func signInWithCredential(credential: AuthCredential, username: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            guard let result else { return }
            
            let ref = Firestore.firestore().collection("UsersInfo").document(result.user.uid)
            
            let data = [
                "userName" : username,
                "recentSearches" : []
            ] as! [String : Any]
            
            ApplicationVariables.currentUserID = result.user.uid
            ref.setData(data) { error in
                if let error { onError(error) }
                onSuccess()
            }
        }
    }
    
    func signOut(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        do {
            try Auth.auth().signOut()
            ApplicationVariables.resetApplicationVariables()
            onSuccess()
        } catch {
            onError(error)
        }
    }
    
    func resetPassword(email: String, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error { onError(error.localizedDescription) }
            onSuccess()
        }
    }
    
}
