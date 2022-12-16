import UIKit

final class FirstScreenViewController: UIViewController {
    
    //MARK: - UIElements
    
    private lazy var nextButton : UIButton = {
        let nextButton = UIButton()
        nextButton.backgroundColor = UIColor(red: 244/255, green: 201/255, blue: 70/255, alpha: 1)
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        nextButton.titleLabel!.font = .boldSystemFont(ofSize: 30)
        nextButton.setTitle("START COOKING", for: .normal)
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.layer.cornerRadius = .nextButtonHeightAnchor / 2
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
            nextButton.heightAnchor.constraint(equalToConstant: .nextButtonHeightAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: .nextButtonWidthAnchor),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.nextButtonHeightAnchor)
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

//MARK: - Constant constrains

private extension CGFloat {
    
    static let nextButtonWidthAnchor: CGFloat = 300
    static let nextButtonHeightAnchor : CGFloat = 60
    
    
}


