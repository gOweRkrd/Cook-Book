import UIKit


class KitchenViewController: UIViewController  {
    
    let headerView = HeaderView()
    let myTableView = UITableView()

    private var manager = RecipeManager()
    private let storageManager = StorageManager.shared
    private var cuisineRecipes = [CuisineRecipe]()
    private var favoriteIds: Set<Int> = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        headerView.delegate = self
        
        setupTableView()
        setupConstraints()
        colorView()
        
        manager.fetchCuisineRecipe(cuisine: .american)
        favoriteIds = storageManager.fetchIds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteIds = storageManager.fetchIds()
        myTableView.reloadData()
    }
}

extension KitchenViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cuisineRecipes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? MyOwnCell  else {
            return UITableViewCell()
        }
        
        let recipe = cuisineRecipes[indexPath.row]
       
        cell.titleRecipe.text = cuisineRecipes[indexPath.row].title
        cell.delegate = self
        cell.configureCell(isFavorite: favoriteIds.contains(recipe.id), id: recipe.id)
        
        if let url = cuisineRecipes[indexPath.row].image {
            self.manager.downloadImage(from: url) { [weak cell] image in
                DispatchQueue.main.async {
                    cell?.imageRecipe.image = image
                }
            }
        }
        return cell
    }
}

extension KitchenViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailViewController()
        let recipeId = cuisineRecipes[indexPath.row].id
        detailVC.id = recipeId
        detailVC.isFavorite = favoriteIds.contains(recipeId)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension KitchenViewController: RecipeManagerDelegate {
    
    // MARK: - RecipeManagerDelegate
    
    func didFailWithError(error: String) {
        let alertVC = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertVC, animated: true)
        }
    }
    
    func didCuisinesRecipe(recipes: [CuisineRecipe]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            self.cuisineRecipes = recipes
            self.myTableView.reloadData()
            
        }
    }
    
    func didUpdateDetailRecipe(recipe: DetailRecipe) {
        
    }
    
    func didUpdateSearchRecipes(recipes: [SearchRecipe]) {
        
    }
}

extension KitchenViewController: HeaderViewDelegate {
    func didTapCuisineButton(cuisine: Cuisine) {
        manager.fetchCuisineRecipe(cuisine: cuisine)
    }
}
extension KitchenViewController: MyOwnCellDelegate {
    
    // MARK: - MyOwnCellDelegate
    
    func didTapFavoriteButton(_ id: Int) {
        guard let cuisineRecipe = cuisineRecipes.first(where: { $0.id == id }) else {
            return
        }
        
        if favoriteIds.contains(id) {
            favoriteIds.remove(id)
            storageManager.delete(id)
        } else {
            favoriteIds.insert(id)
            let recipe = storageManager.createItem(from: cuisineRecipe)
            storageManager.saveRecipe(recipe)
        }
    }
    
    
    
}
