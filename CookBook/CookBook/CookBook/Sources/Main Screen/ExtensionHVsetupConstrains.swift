import UIKit

extension HeaderView {
    
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
            welcomeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
        
        NSLayoutConstraint.activate([
            americanButton.topAnchor.constraint(equalTo: welcomeTitle.topAnchor, constant:.americanButtonTopAnchor),
            americanButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .americanButtonLeadingAnchor),
            americanButton.trailingAnchor.constraint(equalTo:japaneseButton.trailingAnchor,constant:.americanButtonTrailingAnchor),
            americanButton.heightAnchor.constraint(equalToConstant: .americanButtonHeightAnchor)])
        
        NSLayoutConstraint.activate([
            japaneseButton.topAnchor.constraint(equalTo: welcomeTitle.topAnchor, constant:.japaneseButtonTopAnchor),
            japaneseButton.leadingAnchor.constraint(equalTo:americanButton.trailingAnchor,constant:.japeneseButtonLeadingAnchor),
            japaneseButton.trailingAnchor.constraint(equalTo: germanButton.trailingAnchor,constant:.japaneseButtonTrailingAnchor),
            japaneseButton.heightAnchor.constraint(equalToConstant: .japaneseButtonHeightAnchor)])
        
        NSLayoutConstraint.activate([
            germanButton.topAnchor.constraint(equalTo: welcomeTitle.topAnchor, constant:.germanButtonTopAnchor),
            germanButton.leadingAnchor.constraint(equalTo: japaneseButton.trailingAnchor,constant:.japeneseButtonLeadingAnchor),
            germanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .germanButtonTrailingAnchor),
            germanButton.heightAnchor.constraint(equalToConstant: .germanButtonHeightAnchor)])
        
        NSLayoutConstraint.activate([
            italianButton.topAnchor.constraint(equalTo: americanButton.topAnchor, constant:.italianButtonTopAnchor),
            italianButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .italianButtonLeadingAnchor),
            italianButton.trailingAnchor.constraint(equalTo: koreanButton.trailingAnchor,constant:.italianButtonTrailingAnchor),
            italianButton.heightAnchor.constraint(equalToConstant: .italianButtonHeightAnchor)])
        
        NSLayoutConstraint.activate([
            koreanButton.topAnchor.constraint(equalTo: japaneseButton.topAnchor, constant:.koreanButtonTopAnchor),
            koreanButton.leadingAnchor.constraint(equalTo:italianButton.trailingAnchor,constant:.koreanButtonTopAnchorButtonLeadingAnchor ),
            koreanButton.trailingAnchor.constraint(equalTo: mexicanButton.trailingAnchor,constant:.koreanButtonTopAnchorButtonTrailingAnchor),
            koreanButton.heightAnchor.constraint(equalToConstant: .koreanButtonTopAnchorButtonHeightAnchor)])
    
        NSLayoutConstraint.activate([
            mexicanButton.topAnchor.constraint(equalTo: japaneseButton.topAnchor, constant:.mexicanButtonTopAnchor),
            mexicanButton.leadingAnchor.constraint(equalTo:koreanButton.trailingAnchor,constant:.mexicanButtonLeadingAnchor) ,
            mexicanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .mexicanButtonTrailingAnchor),
            mexicanButton.heightAnchor.constraint(equalToConstant: .mexicanButtonHeightAnchor)])
        
    }
    
    func configureView() {
        setupView()
        setupConstraints()
    }
}

private extension CGFloat {
    
    static let welcomeTitleTopAncor: CGFloat = 40
    static let welcomeTitleHeightAnchor: CGFloat = 80.0
    
    static let americanButtonTopAnchor: CGFloat = 70
    static let americanButtonLeadingAnchor: CGFloat = 10
    static let americanButtonTrailingAnchor: CGFloat = -125
    static let americanButtonHeightAnchor : CGFloat = 50
    
    static let japaneseButtonTopAnchor: CGFloat = 70
    static let japeneseButtonLeadingAnchor: CGFloat = 5
    static let japaneseButtonTrailingAnchor: CGFloat = -125
    static let japaneseButtonHeightAnchor : CGFloat = 50
    
    static let germanButtonTopAnchor: CGFloat = 70
    static let germanButtonLeadingAnchor: CGFloat = 5
    static let germanButtonTrailingAnchor: CGFloat = -10
    static let germanButtonHeightAnchor : CGFloat = 50
    
    static let italianButtonTopAnchor: CGFloat = 60
    static let italianButtonLeadingAnchor: CGFloat = 10
    static let italianButtonTrailingAnchor: CGFloat = -125
    static let italianButtonHeightAnchor : CGFloat = 50
    
    static let koreanButtonTopAnchor: CGFloat = 60
    static let koreanButtonTopAnchorButtonLeadingAnchor: CGFloat = 5
    static let koreanButtonTopAnchorButtonTrailingAnchor: CGFloat = -125
    static let koreanButtonTopAnchorButtonHeightAnchor : CGFloat = 50
    
    static let mexicanButtonTopAnchor: CGFloat = 60
    static let mexicanButtonLeadingAnchor: CGFloat = 5
    static let mexicanButtonTrailingAnchor: CGFloat = -10
    static let mexicanButtonHeightAnchor : CGFloat = 50
    
}
