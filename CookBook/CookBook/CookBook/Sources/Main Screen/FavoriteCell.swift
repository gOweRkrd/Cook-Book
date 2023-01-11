import UIKit

final class FavoriteCell: UITableViewCell {
    
    private let manager = RecipeManager()
    
    // MARK: - UIElements
    
    private lazy var imageRecipe: UIImageView = {
        let imageRecipe = UIImageView()
        imageRecipe.contentMode = .scaleAspectFill
        imageRecipe.layer.masksToBounds = true
        imageRecipe.layer.cornerRadius = 20
        return imageRecipe
    }()
    
    private lazy var titleRecipe: UILabel = {
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
    
    // MARK: - Private Method
    
    private func setupCell() {
        contentView.addSubviews([
            imageRecipe,
            titleRecipe
        ])
    }
}

// MARK: - Constrains

private extension FavoriteCell {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageRecipe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .tenSizeAnchor),
            imageRecipe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .imageRecipeSizeAnchor),
            imageRecipe.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.imageRecipeSizeAnchor),
            imageRecipe.widthAnchor.constraint(equalTo: imageRecipe.heightAnchor),
            
            titleRecipe.leadingAnchor.constraint(equalTo: imageRecipe.trailingAnchor, constant: .titleRecipeSizeAnchor),
            titleRecipe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.titleRecipeSizeAnchor),
            titleRecipe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .tenSizeAnchor),
            titleRecipe.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.tenSizeAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    static let tenSizeAnchor: CGFloat = 10
    static let imageRecipeSizeAnchor: CGFloat = 5
    static let titleRecipeSizeAnchor: CGFloat = 12
}
