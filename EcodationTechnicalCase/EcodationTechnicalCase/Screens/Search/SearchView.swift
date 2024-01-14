//
//  SearchView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//


import UIKit

final class SearchView: UIView {
    
    //MARK: - Properties
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        backgroundColor = .systemPink
    }
    
}
