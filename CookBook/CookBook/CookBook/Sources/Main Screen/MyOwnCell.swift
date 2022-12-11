//
//  MyOwnCell.swift
//  CookBook
//
//  Created by Александр Косяков on 08.12.2022.
//

import UIKit

protocol MyOwnCellDelegate: AnyObject {
    func didTapFavoriteButton(_ id: Int)
}

final class MyOwnCell: UITableViewCell  {
    
    weak var delegate: MyOwnCellDelegate?
    
    private var id: Int?
    private var isFavorite = false
    
    //MARK: - UIElements
    
    lazy var imageRecipe : UIImageView = {
        let imageRecipe = UIImageView ()
        imageRecipe.backgroundColor = .red
        imageRecipe.contentMode = .scaleAspectFill
        return imageRecipe
    }()
    
    lazy var titleRecipe : UILabel = {
        let titleRecipe = UILabel()
        titleRecipe.font = UIFont.systemFont(ofSize: 14)
        titleRecipe.font = UIFont.boldSystemFont(ofSize: 14)
        titleRecipe.numberOfLines = 10
        titleRecipe.textAlignment = .justified
        titleRecipe.textAlignment = .center
        titleRecipe.textColor = .black
        return titleRecipe
    }()
    
    lazy var favouritesButton : UIButton = {
        let favouritesButton = UIButton ()
        favouritesButton.setTitleColor(UIColor.black, for: .normal)
        favouritesButton.addTarget(self, action: #selector(favouritesTapButton(_:)), for:.touchUpInside)
        return favouritesButton
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        castomizeCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(isFavorite: Bool, id: Int) {
        self.isFavorite = isFavorite
        self.id = id
        changeFavorite()
    }
    
    private func castomizeCell () {
        contentView.backgroundColor = UIColor(red: 240/255, green: 235/255, blue: 231/255, alpha: 1)
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
    }
    // MARK: - Action
    
    @objc private func favouritesTapButton(_ sender: UIButton!) {
        if let id {
            isFavorite.toggle()
            changeFavorite()
            delegate?.didTapFavoriteButton(id)
        }
    }
    
    private func changeFavorite() {
        if isFavorite {
            favouritesButton.setImage(UIImage(named: "star.png"), for: .normal)
        } else {
            favouritesButton.setImage(UIImage(named: "star(base).png"), for: .normal)
        }
    }
}
