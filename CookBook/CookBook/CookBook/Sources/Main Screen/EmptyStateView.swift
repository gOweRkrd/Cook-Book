//
//  EmptyStateView.swift
//  CookBook
//
//  Created by Дария Григорьева on 10.12.2022.
//

import UIKit

final class EmptyStateView: UIView {
    
    //MARK: - UIElements
    
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
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constrains
    
    private func setupView() {
        addSubviews([messageLabel, imageView])
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .messageLabelSizeAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.messageLabelSizeAnchor),
        
            imageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -.messageLabelSizeAnchor),
            imageView.widthAnchor.constraint(equalToConstant: .imageViewSizeAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .imageViewSizeAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    static let messageLabelSizeAnchor: CGFloat = 20
    static let imageViewSizeAnchor: CGFloat = 200
    
}


