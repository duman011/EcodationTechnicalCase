//
//  FirebaseAuthManager.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//


import FirebaseAuth
import FirebaseFirestore

protocol FirebaseAuthManagerProtocol {
    func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void)
    func register(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void)
    func signInWithCredential(credential: AuthCredential, email: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void)
    func signOut(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void)
    func resetPassword(email: String, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
}


final class FirebaseAuthManager: FirebaseAuthManagerProtocol {
    
    static let shared = FirebaseAuthManager()
    
    private init() {}
    
    /// Kullanıcı girişi yapma fonksiyonu.
    /// - Parameters:
    ///   - email: Kullanıcının e-posta adresi.
    ///   - password: Kullanıcının şifresi.
    ///   - onSuccess: Giriş başarılı olduğunda çağrılacak olan @escaping bloğu.
    ///   - onError: Giriş başarısız olduğunda çağrılacak olan @escaping bloğu.
       
    func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error { onError(error) }
            guard let result else { return }
            ApplicationVariables.currentUserID = result.user.uid
            onSuccess()
        }
    }
    
    func register(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error { onError(error) }
            guard let result else { return }
            let ref = Firestore.firestore().collection("UsersInfo").document((result.user.uid))
            let data = [
                "email" : email
            ] as! [String : Any]
            
            ApplicationVariables.currentUserID = result.user.uid
            FirestoreService.shared.setData(reference: ref, data: data) {
                onSuccess()
            } onError: { error in
                onError(error)
            }
        }
    }
    
    /// Üçüncü taraf kimlik doğrulama ile giriş yapma fonksiyonu.
    /// - Parameters:
    ///   - credential: Üçüncü taraf kimlik doğrulama verisi.
    ///   - email: Kullanıcının e-posta adresi.
    ///   - onSuccess: Giriş başarılı olduğunda çağrılacak olan kapanış bloğu.
    ///   - onError: Giriş başarısız olduğunda çağrılacak olan kapanış bloğu.
    func signInWithCredential(credential: AuthCredential, email: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            guard let result else { return }
            
            let ref = Firestore.firestore().collection("UsersInfo").document(result.user.uid)
            
            let data = [
                "email" : email
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
