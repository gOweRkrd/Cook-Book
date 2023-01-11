import UIKit

final class CuisineButton: UIButton {
    
    let cuisine: Cuisine
    private let text: String
    
    // MARK: - Initialization
    
    init(text: String, cuisine: Cuisine) {
        self.text = text
        self.cuisine = cuisine
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    
    private func setupView() {
        setTitle(text, for: .normal)
        setTitleColor(UIColor.black, for: .normal)
        layer.cornerRadius = 14
        layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = .white
    }
    
}
