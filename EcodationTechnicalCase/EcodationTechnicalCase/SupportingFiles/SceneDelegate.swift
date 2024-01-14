//
//  SceneDelegate.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // MARK: - kullanıcı sürekli giriş yapmamsı için yapılan işlem kullanıcıyı hatırlama işlemi
        if ApplicationVariables.currentUserID != nil {
            let TabBar = MainTabBarController()
            TabBar.modalPresentationStyle = .fullScreen
            window?.rootViewController = TabBar
        }else {
            let vc = UINavigationController(rootViewController: LoginVC())
            window?.rootViewController = vc
        }
        
        self.window?.makeKeyAndVisible()

    }
    
    
    
    
}

