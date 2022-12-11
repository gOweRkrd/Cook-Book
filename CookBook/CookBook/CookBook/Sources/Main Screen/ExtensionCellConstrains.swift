import UIKit

extension MyOwnCell {
    
    private func setupConstraintsCell() {
        
        NSLayoutConstraint.activate([
            titleRecipe.topAnchor.constraint(equalTo: contentView.topAnchor,constant:.titleRecipeLabelTopAnchor),
            titleRecipe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:.titleRecipeLabelLeadingAnchor),
            titleRecipe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:.titleRecipeLabelTrailingAnchor),
            titleRecipe.heightAnchor.constraint(equalTo: contentView.heightAnchor,constant:.titleRecipeLabelHeightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageRecipe.topAnchor.constraint(equalTo: contentView.topAnchor,constant:.imageRecipeTopAnchor),
            imageRecipe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:.imageRecipeLeadingAnchor),
            imageRecipe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:.imageRecipeTrailingAnchor),
            imageRecipe.heightAnchor.constraint(equalTo: contentView.heightAnchor,constant:.imageRecipeHeightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            favouritesButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant:.favouritesButtonLabelTopAnchor),
            favouritesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:.favouritesButtonLabelLeadingAnchor),
            favouritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:.favouritesButtonLabelTrailingAnchor),
            favouritesButton.heightAnchor.constraint(equalTo: contentView.heightAnchor,constant:.favouritesButtonLabelHeightAnchor),
        ])
    }
    
    func setupCell() {
        contentView.addSubviews([
            titleRecipe,
            imageRecipe,
            favouritesButton
        ])
    }
    
    func configureView() {
        setupCell()
        setupConstraintsCell()
        
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    static let imageRecipeTopAnchor: CGFloat = 20
    static let imageRecipeLeadingAnchor: CGFloat = 80
    static let imageRecipeTrailingAnchor: CGFloat = -180
    static let imageRecipeHeightAnchor: CGFloat = -70
    
    static let titleRecipeLabelTopAnchor: CGFloat = 130
    static let titleRecipeLabelLeadingAnchor: CGFloat = 10
    static let titleRecipeLabelTrailingAnchor: CGFloat = -120
    static let titleRecipeLabelHeightAnchor : CGFloat = -85
    
    static let favouritesButtonLabelTopAnchor: CGFloat = 16
    static let favouritesButtonLabelLeadingAnchor: CGFloat = 330
    static let favouritesButtonLabelTrailingAnchor: CGFloat = -130
    static let favouritesButtonLabelHeightAnchor : CGFloat = -200
    
}
