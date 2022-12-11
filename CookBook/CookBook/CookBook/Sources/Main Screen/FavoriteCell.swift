//
//  FavoriteCell.swift
//  CookBook
//
//  Created by Дария Григорьева on 10.12.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    private let manager = RecipeManager()
    
    //MARK: - UIElements
    
    private lazy var imageRecipe : UIImageView = {
        let imageRecipe = UIImageView()
        imageRecipe.contentMode = .scaleAspectFill
        imageRecipe.layer.masksToBounds = true
        imageRecipe.layer.cornerRadius = 20
        return imageRecipe
    }()
    
    private lazy var titleRecipe : UILabel = {
        let titleRecipe = UILabel()
        titleRecipe.font = UIFont.systemFont(ofSize: 14)
        titleRecipe.font = UIFont.boldSystemFont(ofSize: 14)
        titleRecipe.numberOfLines = 2
        titleRecipe.textAlignment = .justified
        titleRecipe.textAlignment = .center
        titleRecipe.textColor = .black
        return titleRecipe
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupConstraints()
        
    }
    
    func setup(title: String, imageUrl: String?) {
        titleRecipe.text = title
        
        if let url = imageUrl {
            self.manager.downloadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageRecipe.image = image
                }
            }
        }
        setNeedsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubviews([
            imageRecipe,
            titleRecipe
        ])
    }
}

//MARK: - Constrains

private extension FavoriteCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageRecipe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageRecipe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageRecipe.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageRecipe.widthAnchor.constraint(equalTo: imageRecipe.heightAnchor),
            
            titleRecipe.leadingAnchor.constraint(equalTo: imageRecipe.trailingAnchor, constant: 12),
            titleRecipe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleRecipe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleRecipe.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
