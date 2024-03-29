//
//  AlertContainerView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

final class AlertContainerView: UIView {
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Methods
    private func configureUI() {
       backgroundColor = .systemBackground
       layer.cornerRadius = 16
       layer.borderWidth = 2
       layer.borderColor = UIColor.white.cgColor
       translatesAutoresizingMaskIntoConstraints = false
    }
}
