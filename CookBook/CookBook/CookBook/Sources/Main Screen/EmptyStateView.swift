//
//  EmptyStateView.swift
//  CookBook
//
//  Created by Дария Григорьева on 10.12.2022.
//

import UIKit

class EmptyStateView: UIView {
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Add your favorite recipe in the kitchen"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .tabBarItemAccent
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "fork.knife.circle")
        imageView.tintColor = .mainWhite
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        addSubviews([messageLabel, imageView])
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        
            imageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
