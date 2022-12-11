import UIKit

class FirstScreenViewController: UIViewController {
    
    //MARK: - UIElements
    
    private lazy var nextButton : UIButton = {
        let nextButton = UIButton()
        nextButton.backgroundColor = UIColor(red: 244/255, green: 201/255, blue: 70/255, alpha: 1)
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        nextButton.setTitle("Start cooking  -> -> -> ", for: .normal)
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.layer.cornerRadius = 14
        return nextButton
    } ()
    
    private lazy var imageViewFirstScreen : UIImageView = {
        let imageViewFirstScreen = UIImageView()
        imageViewFirstScreen.image = UIImage(named: "cooking")
        imageViewFirstScreen.contentMode = .scaleAspectFill
        return imageViewFirstScreen
    } ()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewFistScreen()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Action
    
    @objc private func goToNextScreen() {
        let nextScreen = TabBarController()
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
}

//MARK: - Constrains

extension FirstScreenViewController {
    
    private func setupConstraintsFirstScreen() {
        NSLayoutConstraint.activate([
            imageViewFirstScreen.topAnchor.constraint(equalTo: view.topAnchor),
            imageViewFirstScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewFirstScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewFirstScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
       
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant:.nextButtonBottomAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .nextButtonLeadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .nextButtonTrailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: .nextButtonHeightAnchor)
        ])
        
    }
    
    private func setupFirstScreen() {
        view.addSubviews([
            imageViewFirstScreen,
            nextButton,
        ])
        
    }
    
    private func configureViewFistScreen() {
        setupFirstScreen()
        setupConstraintsFirstScreen()
        
    }
}

private extension CGFloat {
    
    static let imageViewButtonTopAnchor: CGFloat = 250
    static let imageViewButtonLeadingAnchor: CGFloat = 0
    static let imageViewButtonTrailingAnchor: CGFloat = -0
    static let imageViewButtonHeightAnchor : CGFloat = 1
    
    static let nextButtonBottomAnchor: CGFloat = -200
    static let nextButtonLeadingAnchor: CGFloat = 40
    static let nextButtonTrailingAnchor: CGFloat = -40
    static let nextButtonHeightAnchor : CGFloat = 60
    
    static let commandLabelTopAnchor: CGFloat = 50
    static let commandLabelLeadingAnchor: CGFloat = 20
    static let commandLabelTrailingAnchor: CGFloat = -20
    static let commandLabelHeightAnchor : CGFloat = 60
    
}


