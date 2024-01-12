//
//  SceneDelegate.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = UINavigationController(rootViewController: LoginVC())
        window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
    
    
    
    
}

