//
//  AlertVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//



import UIKit

final class AlertVC: UIViewController {
    // MARK: - Properties
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    //MARK: - UI Elements
    lazy var containerView  = AlertContainerView()
    lazy var titleLabel     = TitleLabel( fontSize: 20, textAlignment: .center,lineBreakMode: .byTruncatingTail)
    lazy var messageLabel   = SecondaryTitleLabel(fontSize: 17, textAlignment: .center, lineBreakMode: .byWordWrapping)
    lazy var actionButton   = CustomButton(bgColor: .systemPink, color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")
    
    //MARK: - Initializers
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle   = title
        self.message      = message
        self.buttonTitle  = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviewsExt(containerView, titleLabel, actionButton, messageLabel)
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
           configureContainerView()
           configureTitleLabel()
           configureMessageLabel()
           configureActionButton()
    }
    
    private func configureContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
              containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              containerView.heightAnchor.constraint(equalToConstant: 220),
              containerView.widthAnchor.constraint(equalToConstant: 280)
          ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    private func configureMessageLabel(){
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Actions
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
