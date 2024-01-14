//
//  SecondaryTitleLabel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//


import UIKit

final class SecondaryTitleLabel: UILabel {
    
    enum FontWeight {
        case regular, semibold, bold
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Convenience Initializer
    convenience init(text:String? = nil, fontSize: CGFloat, textAlignment: NSTextAlignment = .left, fontWeight: FontWeight = .semibold, lineBreakMode: NSLineBreakMode? = nil, textColor: UIColor = .label, numberOfLines: Int = 0) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWightToUIFontWeight(weight: fontWeight))
        self.lineBreakMode = lineBreakMode ?? .byTruncatingTail
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
    
    //MARK: - Configuration Methods
    private func configureUI() {
        adjustsFontForContentSizeCategory         = true // İçerik boyutu kategorisine göre yazı fontunu ayarlar.
        adjustsFontSizeToFitWidth                 = true // Yazının genişliğine sığdırılmasını sağlar.
        minimumScaleFactor                        = 0.9  // Eğer yazı sığdırılamazsa en küçük ölçek faktörü.
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func fontWightToUIFontWeight(weight: FontWeight) -> UIFont.Weight {
        switch weight {
        case .regular:
            return .regular
        case .semibold:
            return .semibold
        case .bold:
            return .bold
        }
    }
}
