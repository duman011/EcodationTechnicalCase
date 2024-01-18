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
        
        let vc = LauncScreenAnimation()
        window?.rootViewController = vc
 
        self.window?.makeKeyAndVisible()
        
        // MARK: - SDWebImage
        print("------->>>>>> ImageCache TotalSize: \(SDImageCache.shared.diskCache.totalSize())")
        //~19.06 MB tekabül eder
        SDImageCache.shared.config.maxDiskSize = 1000000 * 20
    }
}

