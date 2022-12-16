import UIKit

final class DetailViewController: UIViewController {
    
    var id: Int?
    var isFavorite = false
    
    private let storageManager = StorageManager.shared
    private let cellReuseIdentifier = "cell"
    
    private var manager = RecipeManager()
    private var ingredients = [Ingredient]()
    private var detailRecipe: DetailRecipe?
    private var text: String?
    
    //MARK: - UIElements
    
    private var  scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 21)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 10
        label.backgroundColor = .backgroundColor
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                          action: #selector(didTapDescriptionLabel)))
        return label
    }()
    
    private lazy var favouriteButton : UIButton = {
        let favouritesButton = UIButton ()
        favouritesButton.setTitleColor(UIColor.black, for: .normal)
        favouritesButton.addTarget(self, action: #selector(didTapFavoriteButton), for:.touchUpInside)
        return favouritesButton
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        tabBarController?.tabBar.isHidden = true
        
        setupHierarchy()
        setupLayout()
        setupView()
        changeFavorite()
        fetchDelegate()
    }
    private func fetchDelegate() {
        manager.delegate = self
        if let id = id {
            manager.fetchDetailRecipe(id: String(id))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.backgroundColor = .clear
    }
    
    // MARK: - Action
    
    @objc private func didTapFavoriteButton() {
        if isFavorite, let id {
            storageManager.delete(id)
        } else if let detailRecipe, let id {
            let cuisineRecipe = CuisineRecipe(id: id, title: detailRecipe.title, image: detailRecipe.image)
            let recipe = storageManager.createItem(from: cuisineRecipe)
            storageManager.saveRecipe(recipe)
        }
        isFavorite.toggle()
        changeFavorite()
        
    }
    
    @objc private func didTapDescriptionLabel() {
        if let text {
            let alertVC = CustomAlertVC(message: text)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            present(alertVC, animated: true)
        }
        
    }
    
    //MARK: - Private Method
    
    private func changeFavorite() {
        if isFavorite {
            favouriteButton.setImage(UIImage(named: "star.png"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "star(base).png"), for: .normal)
        }
    }
}

// MARK: - RecipeManagerDelegate

extension DetailViewController: RecipeManagerDelegate {
    
    func didFailWithError(error: String) {
        let alertVC = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertVC, animated: true)
        }
    }
    
    func didUpdateDetailRecipe(recipe: DetailRecipe) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            self.detailRecipe = recipe
            
            self.ingredients = recipe.extendedIngredients
            self.nameLabel.text = recipe.title
            self.descriptionLabel.text = recipe.summary.htmlToString
            self.text = recipe.summary.htmlToString
            self.manager.downloadImage(from: recipe.image) { [weak self] image in
                DispatchQueue.main.async {
                    self?.image.image = image
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func didCuisinesRecipe(recipes: [CuisineRecipe]) { }
    func didUpdateSearchRecipes(recipes: [SearchRecipe]) { }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let ingredient = ingredients[indexPath.row]
        let unit = ingredient.unit ?? ""
        cell.textLabel?.text = ingredient.name + ", \(ingredient.amount) " + unit
        
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
    }
}


// MARK: - Constrains

extension DetailViewController {
    
    private func setupHierarchy() {
        view.addSubviews([
            image,
            nameLabel,
            descriptionLabel,
            tableView,
            favouriteButton
        ])
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 1.fitScreen),
            
            favouriteButton.topAnchor.constraint(equalTo: image.topAnchor, constant: .tenSizeAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: .favouriteButtonAnchorTrailingAnchor),
            favouriteButton.widthAnchor.constraint(equalToConstant: .favouriteButtonSize),
            favouriteButton.heightAnchor.constraint(equalToConstant: .favouriteButtonSize),
            
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: .nameLabelTopAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -.twentySizeAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: .twentySizeAnchor),
            
            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .twentySizeAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .tableViewBottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .tenSizeAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .tenSizeAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.tenSizeAnchor),
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    static let tenSizeAnchor: CGFloat = 10
    static let twentySizeAnchor: CGFloat = 20
    static let favouriteButtonAnchorTrailingAnchor: CGFloat = -15
    static let favouriteButtonSize: CGFloat = 50
    static let nameLabelTopAnchor: CGFloat = 5
    static let tableViewBottomAnchor: CGFloat = 30
}

