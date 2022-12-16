import UIKit

final class CustomAlertVC: UIViewController {
    
    //MARK: - UIElements
    
    private let messageLabel = UILabel()
    private let actionButton = UIButton()
    private let padding: CGFloat = 20
    
    private var message: String?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configureActionButton() {
        
        actionButton.backgroundColor = .mainWhite
        actionButton.layer.cornerRadius = 10
        actionButton.setTitle("Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    func configureMessageLabel() {
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message ?? ""
        messageLabel.numberOfLines = 0
    }
    
    // MARK: - Initialization
    
    init(message: String) {
        super.init(nibName: nil, bundle: nil)
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        setupConstraints()
        configureActionButton()
        configureMessageLabel()
    }
    
    // MARK: - Action
    
    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }
}

// MARK: - Constrains

extension CustomAlertVC {

    private func setupConstraints() {
        view.addSubview(containerView)
        containerView.addSubview(actionButton)
        containerView.addSubview(messageLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .containerViewAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.containerViewAnchor),
       
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: .actionButtonHeightAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: .actionButtonWidthAnchor),
        
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .messageLabelTopAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: .messageLabelBottomAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    static let containerViewAnchor: CGFloat = 10
    
    static let actionButtonHeightAnchor: CGFloat = 44
    static let actionButtonWidthAnchor: CGFloat = 200
    
    static let messageLabelTopAnchor: CGFloat = 8
    static let messageLabelBottomAnchor: CGFloat = -12

}
