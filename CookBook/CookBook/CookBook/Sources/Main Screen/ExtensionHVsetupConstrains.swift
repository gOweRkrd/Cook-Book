import UIKit

extension HeaderView {
    
    func configureView() {
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubviews([
            
            welcomeTitle,
            americanButton,
            italianButton,
            japaneseButton,
            mexicanButton,
            germanButton,
            koreanButton
        ])
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            welcomeTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: .welcomeTitleTopAncor),
            welcomeTitle.heightAnchor.constraint(equalToConstant: .welcomeTitleHeightAnchor),
            welcomeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            americanButton.heightAnchor.constraint(equalToConstant: .heightAnchorButton),
            americanButton.widthAnchor.constraint(equalToConstant: .widthAnchorButton.fitWMore),
            americanButton.topAnchor.constraint(equalTo: welcomeTitle.topAnchor, constant: .topAnchorButton),
            americanButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .sideButton),
            
            japaneseButton.heightAnchor.constraint(equalToConstant: .heightAnchorButton),
            japaneseButton.widthAnchor.constraint(equalToConstant: .widthAnchorButton.fitWMore),
            japaneseButton.topAnchor.constraint(equalTo: americanButton.topAnchor),
            japaneseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            germanButton.heightAnchor.constraint(equalToConstant: .heightAnchorButton),
            germanButton.widthAnchor.constraint(equalToConstant: .widthAnchorButton.fitWMore),
            germanButton.topAnchor.constraint(equalTo: americanButton.topAnchor),
            germanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.sideButton),
            
            italianButton.heightAnchor.constraint(equalToConstant: .heightAnchorButton),
            italianButton.widthAnchor.constraint(equalToConstant: .widthAnchorButton.fitWMore),
            italianButton.topAnchor.constraint(equalTo: americanButton.bottomAnchor, constant: .sideButton),
            italianButton.leadingAnchor.constraint(equalTo: americanButton.leadingAnchor),
            
            mexicanButton.heightAnchor.constraint(equalToConstant: .heightAnchorButton),
            mexicanButton.widthAnchor.constraint(equalToConstant: .widthAnchorButton.fitWMore),
            mexicanButton.topAnchor.constraint(equalTo: italianButton.topAnchor),
            mexicanButton.trailingAnchor.constraint(equalTo: germanButton.trailingAnchor),
            
            koreanButton.heightAnchor.constraint(equalToConstant: .heightAnchorButton),
            koreanButton.widthAnchor.constraint(equalToConstant: .widthAnchorButton.fitWMore),
            koreanButton.topAnchor.constraint(equalTo: italianButton.topAnchor),
            koreanButton.centerXAnchor.constraint(equalTo: japaneseButton.centerXAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    
    static let welcomeTitleTopAncor: CGFloat = 40
    static let welcomeTitleHeightAnchor: CGFloat = 80.0
    
    static let heightAnchorButton: CGFloat = 50
    static let widthAnchorButton = 110
    
    static let sideButton: CGFloat = 20
    static let topAnchorButton: CGFloat = 70
}
