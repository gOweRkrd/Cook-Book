import UIKit

protocol HeaderViewDelegate: AnyObject {
    func didTapCuisineButton(cuisine: Cuisine)
}

final class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - UI Elements
    
    lazy var welcomeTitle: UILabel = {
        let welcomeTitle = UILabel()
        welcomeTitle.text = "Choose cuisine:"
        welcomeTitle.font = UIFont.systemFont(ofSize: 30)
        welcomeTitle.font = UIFont.boldSystemFont(ofSize: 30.0)
        welcomeTitle.textAlignment = .center
        welcomeTitle.textColor = .black
        return welcomeTitle
    }()
    
    lazy var americanButton: UIButton = {
        createButton(cuisine: .american)
    }()
    
    lazy var japaneseButton: UIButton = {
        createButton(cuisine: .japanese)
    }()
    
    lazy var germanButton: UIButton = {
        createButton(cuisine: .german)
    }()
    
    lazy var italianButton: UIButton = {
        createButton(cuisine: .italian)
    }()
    
    lazy var koreanButton: UIButton = {
        createButton(cuisine: .korean)
    }()
    
    lazy var mexicanButton: UIButton = {
        createButton(cuisine: .mexican)
    }()
  
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        americanButton.backgroundColor = .mainWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createButton(cuisine: Cuisine) -> CuisineButton {
        let button = CuisineButton(text: cuisine.rawValue, cuisine: cuisine)
        button.addTarget(self,
                         action: #selector(didTapButton(_:)),
                         for: .touchUpInside)
        return button
        
    }
    
    // MARK: - Action
    
    @objc private func didTapButton(_ selector: CuisineButton) {
        delegate?.didTapCuisineButton(cuisine: selector.cuisine)
        
        [americanButton,
         italianButton,
         japaneseButton,
         mexicanButton,
         germanButton,
         koreanButton].forEach { $0.backgroundColor = .white }
        
        selector.backgroundColor = .mainWhite
    }
}
