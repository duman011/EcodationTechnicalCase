//
//  SceneDelegate.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import UIKit
import SDWebImage

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // MARK: - kullanıcı sürekli giriş yapmaması için yapılan işlem kullanıcıyı hatırlama işlemi
        if ApplicationVariables.currentUserID != nil {
            let tabBar = MainTabBarController()
            tabBar.modalPresentationStyle = .fullScreen 
            window?.rootViewController = tabBar
        }else {
            let vc = UINavigationController(rootViewController: LoginVC())
            window?.rootViewController = vc
        }
        
        self.window?.makeKeyAndVisible()
        
        // MARK: - SDWebImage
        print("------->>>>>> DEBUG: \(SDImageCache.shared.diskCache.totalSize())")
        //20 MB'a tekabül eder
        SDImageCache.shared.config.maxDiskSize = 1000000 * 20
    }
    
}

