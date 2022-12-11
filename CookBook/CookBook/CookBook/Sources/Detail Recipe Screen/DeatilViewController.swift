//
//  Name.swift
//  CookBook
//
//  Created by Дария Григорьева on 28.11.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var id: Int?
    var isFavorite = false
    
    //MARK: - UIElements
    
    private var manager = RecipeManager()
    private let storageManager = StorageManager.shared
    private var ingredients = [Ingredient]()
    private let cellReuseIdentifier = "cell"
    private var detailRecipe: DetailRecipe?
    private var text: String?
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 21)
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
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        tabBarController?.tabBar.isHidden = true
        
        setupHierarchy()
        setupLayout()
        setupView()
        manager.delegate = self
        if let id = id {
            manager.fetchDetailRecipe(id: String(id))
        }
        changeFavorite()
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
    
    // MARK: - Setups
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.backgroundColor = .clear
    }
    
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
            image.heightAnchor.constraint(equalToConstant: 250),
            
            favouriteButton.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -10),
            favouriteButton.topAnchor.constraint(equalTo: image.topAnchor, constant: 10),
            favouriteButton.widthAnchor.constraint(equalToConstant: 50),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 250)
            
            
        ])
    }
    
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
    
    private func changeFavorite() {
        if isFavorite {
            favouriteButton.setImage(UIImage(named: "star.png"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "star(base).png"), for: .normal)
        }
    }
}

extension DetailViewController: RecipeManagerDelegate {
    
    // MARK: - RecipeManagerDelegate
    
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
    
    func didCuisinesRecipe(recipes: [CuisineRecipe]) {
        
    }
    
    func didUpdateSearchRecipes(recipes: [SearchRecipe]) {
        
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
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


