import UIKit

extension MyOwnCell {
    
    func configureView() {
        setupCell()
        setupConstraintsCell()
    }
    
    private func setupCell() {
        contentView.addSubviews([
            titleRecipe,
            imageRecipe,
            favouritesButton
        ])
    }
    
    private func setupConstraintsCell() {
        
        NSLayoutConstraint.activate([
            imageRecipe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .imageRecipeTopAnchor),
            imageRecipe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .imageRecipeLeadingAnchor),
            imageRecipe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .imageRecipeTrailingAnchor),
            imageRecipe.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: .imageRecipeHeightAnchor),
            
            titleRecipe.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleRecipe.centerXAnchor.constraint(equalTo: imageRecipe.centerXAnchor, constant: .titleRecipeCenterXAnchor),
            
            favouritesButton.heightAnchor.constraint(equalToConstant: .favouritesButtonHeightTopAnchor),
            favouritesButton.widthAnchor.constraint(equalToConstant: .favouritesButtonWidthTopAnchor),
            favouritesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .favouritesButtonLabelTopAnchor),
            favouritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                       constant: .favouritesButtonLabelTrailingAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    static let imageRecipeTopAnchor: CGFloat = 10
    static let imageRecipeLeadingAnchor: CGFloat = 15
    static let imageRecipeTrailingAnchor: CGFloat = -110
    static let imageRecipeHeightAnchor: CGFloat = -30
    
    static let titleRecipeCenterXAnchor: CGFloat = 5

    static let favouritesButtonHeightTopAnchor: CGFloat = 50
    static let favouritesButtonWidthTopAnchor: CGFloat = 50
    static let favouritesButtonLabelTopAnchor: CGFloat = 16
    static let favouritesButtonLabelTrailingAnchor: CGFloat = -130
   
}
