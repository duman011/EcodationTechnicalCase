//
//  RegisterView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

// MARK: - Register View Protocol
protocol RegisterViewProtocol: AnyObject {
    func signUpTapped()
    func loginTapped()

}

final class RegisterView: UIView {

    //MARK: - Properties
    weak var delegate: RegisterViewProtocol?
    
    private lazy var registerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "video.badge.waveform")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var registerTitle: UILabel = {
        let label = UILabel()
        label.text = "The Movie Manager"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.adjustsFontSizeToFitWidth = true // metni otomatik olarak küçült
        label.minimumScaleFactor = 0.7 // minimum küçültme faktörü
        return label
    }()
    
    private lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField      = CustomTextField(fieldType: .email)
    private lazy var passwordTextField   = CustomTextField(fieldType: .password)
    private lazy var rePasswordTextField = CustomTextField(fieldType: .password)
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: UIControl.State.normal)
        button.frame.size = .init(width: 0, height: 40)
        button.layer.cornerRadius   = 5
        button.backgroundColor = .loginButtonBG
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var registerVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerLabel,
                                                       emailTextField,
                                                       passwordTextField,
                                                       rePasswordTextField,
                                                       signUpButton
                                                      ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
                
        return stackView
    }()
    
    private lazy var dontAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login.", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginHStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dontAccountLabel,
                                                       loginButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "This product uses the TMDb API but is not endorsed or certified by TMDb."
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
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
        addSubviewsExt(registerImage, registerTitle, registerVStack, loginHStack, infoLabel)
        configureImage()
        configureLoginTitle()
        configureTextField()
        configureLoginVStack()
        configureSignUpHStack()
        configureInfoLabel()
    }
    
    private func configureImage() {
        registerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            registerImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerImage.heightAnchor.constraint(equalToConstant: 120),
            registerImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureLoginTitle() {
        registerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerTitle.topAnchor.constraint(equalTo: registerImage.bottomAnchor, constant: 5),
            registerTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configureTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        rePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        rePasswordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configureLoginVStack() {
        registerVStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerVStack.topAnchor.constraint(equalTo: registerTitle.bottomAnchor, constant: 50),
            registerVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            registerVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func configureSignUpHStack() {
        loginHStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginHStack.topAnchor.constraint(equalTo: registerVStack.bottomAnchor),
            loginHStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    //MARK: - @Actions
    @objc private func didTapSignUp() {
        delegate?.signUpTapped()
    }
    
    @objc private func didTapLogin() {
        delegate?.loginTapped()
    }
}
