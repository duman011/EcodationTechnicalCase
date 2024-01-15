//
//  ForgotPasswordView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

protocol ForgotPasswordViewProtocol: AnyObject{
    func forgotPasswordTapped()
    func loginTapped()
}

final class ForgotPasswordView: UIView {

    //MARK: - Properties
    weak var delegate: ForgotPasswordViewProtocol?
    
    private lazy var forgotPasswordImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "video.badge.waveform")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var forgotPasswordTitle: UILabel = {
        let label = UILabel()
        label.text = "The Movie Manager"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.adjustsFontSizeToFitWidth = true // metni otomatik olarak küçült
        label.minimumScaleFactor = 0.7 // minimum küçültme faktörü
        return label
    }()
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField = CustomTextField(fieldType: .email)
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: UIControl.State.normal)
        button.frame.size = .init(width: 0, height: 40)
        button.layer.cornerRadius   = 5
        button.backgroundColor = .loginButtonBG
        button.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
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
        let stackView = UIStackView(arrangedSubviews: [accountLabel,
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
        addSubviewsExt(forgotPasswordImage, forgotPasswordTitle, forgotPasswordLabel, emailTextField, forgotPasswordButton, loginHStack, infoLabel)
        
        configureImage()
        configureForgotPasswordTitle()
        configureForgotPasswordLabel()
        configureTextField()
        configureForgotPasswordButton()
        configureLoginHStack()
        configureInfoLabel()
    }
    
    private func configureImage() {
        forgotPasswordImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            forgotPasswordImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            forgotPasswordImage.heightAnchor.constraint(equalToConstant: 120),
            forgotPasswordImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureForgotPasswordTitle() {
        forgotPasswordTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordTitle.topAnchor.constraint(equalTo: forgotPasswordImage.bottomAnchor, constant: 5),
            forgotPasswordTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configureForgotPasswordLabel() {
        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: forgotPasswordTitle.bottomAnchor, constant: 50),
            forgotPasswordLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureForgotPasswordButton() {
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureLoginHStack() {
        loginHStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginHStack.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor),
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
    
    // MARK: - @Actions
    @objc private func didTapForgotPassword() {
        delegate?.forgotPasswordTapped()
    }
    
    @objc private func didTapLogin() {
        delegate?.loginTapped()
    }
}
