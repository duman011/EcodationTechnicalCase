//
//  LoginView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import UIKit

final class LoginView: UIView {
    
    //MARK: - Properties
    private lazy var loginImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "video.badge.waveform")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.text = "The Movie Manager"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.adjustsFontSizeToFitWidth = true // metni otomatik olarak küçült
        label.minimumScaleFactor = 0.7 // minimum küçültme faktörü
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login with Email"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField    = CustomTextField(fieldType: .email)
    private lazy var passwordTextField = CustomTextField(fieldType: .password)
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: UIControl.State.normal)
        button.frame.size = .init(width: 0, height: 40)
        button.layer.cornerRadius   = 5
        button.backgroundColor = .loginButtonBG
        return button
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginViaWebButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login via Website", for: UIControl.State.normal)
        button.frame.size = .init(width: 0, height: 40)
        button.layer.cornerRadius   = 5
        button.backgroundColor = .loginButtonBG
        return button
    }()
    
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "This product uses the TMDb API but is not endorsed or certified by TMDb."
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var loginVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel,
                                                       emailTextField,
                                                      passwordTextField,
                                                      loginButton,
                                                      orLabel,
                                                      loginViaWebButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        // loginLabel'ın altındaki spacing'i sıfır yapma
        stackView.setCustomSpacing(0, after: loginLabel)
        
        // orLabel'ın üst ve altındaki spacing'i sıfır yapma
        stackView.setCustomSpacing(0, after: loginButton)
        stackView.setCustomSpacing(0, after: orLabel)
      
        return stackView
    }()
    
    // Gradient Back Ground
    private lazy var gradientBackGround: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.lightBlue.cgColor,
            UIColor.darkBlue.cgColor,
        ]
        gradient.locations = [0, 0.80, 1]
        gradient.frame = self.bounds
        return gradient
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.insertSublayer(gradientBackGround, at: 0)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        addSubviewsExt(loginImage, loginTitle, loginVStack, infoLabel)
        configureImage()
        configureLoginTitle()
        configureTextField()
        configureLoginVStack()
        configureInfoLabel()
    }
    
    private func configureImage() {
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loginImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginImage.heightAnchor.constraint(equalToConstant: 120),
            loginImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureLoginTitle() {
        loginTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginTitle.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 5),
            loginTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configureTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configureLoginVStack() {
        loginVStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginVStack.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 50),
            loginVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            loginVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func configureInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}