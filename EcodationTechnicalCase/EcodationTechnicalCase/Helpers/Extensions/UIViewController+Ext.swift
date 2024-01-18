//
//  UIViewController+Ext.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//


import UIKit


extension UIViewController {
    // MARK: - Custom Alerts
    func presentAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        self.present(alertVC, animated: true)
    }
}

