//
//  CustomAlertVC.swift
//  CookBook
//
//  Created by Дария Григорьева on 10.12.2022.
//

import UIKit

class CustomAlertVC: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel = UILabel()
    private let actionButton = UIButton()
    private let padding: CGFloat = 20
    
    private var message: String?
    
    init(message: String) {
        super.init(nibName: nil, bundle: nil)
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        configureContainerView()
        configureActionButton()
        configureMessageLabel()
    }
    
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.backgroundColor = .mainWhite
        actionButton.layer.cornerRadius = 10
        actionButton.setTitle("Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message ?? ""
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
