//
//  LauncScreenAnimation.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 18.01.2024.
//

import UIKit


final class LauncScreenAnimation: UIViewController {
    
    //MARK: - Properties
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - LayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: DispatchWorkItem(block: {
            self.animate()
        }))
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        configureImageView()
    }
    
    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 188),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func animate() {
        UIView.animate(withDuration: 1) {
            let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                     self.imageView.transform = scaleTransform
        }
        
        UIView.animate(withDuration: 0.8) {
            self.imageView.alpha = 0
        } completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: DispatchWorkItem(block: {
                    // MARK: - kullanıcı sürekli giriş yapmaması için yapılan işlem kullanıcıyı hatırlama işlemi
                    if ApplicationVariables.currentUserID != nil {
                        let tabBar = MainTabBarController()
                        tabBar.modalPresentationStyle = .fullScreen
                        self.view.window?.rootViewController = tabBar
                    }else {
                        let loginVC = UINavigationController(rootViewController: LoginVC())
                        loginVC.modalTransitionStyle = .crossDissolve
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true)
                    }
                }))
            }
        } 
    }
    
}

