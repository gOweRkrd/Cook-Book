import UIKit

final class SearchViewController: UIViewController {
    
    private let storageManager = StorageManager.shared
    private let identifier = "Cell"
    
    private var manager = RecipeManager()
    private var searchRecipes = [SearchRecipe]()
    private var favoriteIds: Set<Int> = []
    
    // MARK: - UIElements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search recipes"
        search.searchBar.sizeToFit()
        search.searchBar.searchBarStyle = .default
        search.searchBar.delegate = self
        
        return search
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        favoriteIds = storageManager.fetchIds()
        
        navigationItem.searchController = searchController
        view.backgroundColor = .backgroundColor
        
        createTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    private func createTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.frame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = searchRecipes[indexPath.row].title
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailViewController()
        let searchId = searchRecipes[indexPath.row].id
        
        detailVC.id = searchId
        detailVC.isFavorite = favoriteIds.contains(searchId)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            manager.fetchSearchRecipes(text: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchRecipes = []
        tableView.reloadData()
    }
}

extension SearchViewController: RecipeManagerDelegate {
 
    // MARK: - RecipeManagerDelegate
    
    func didFailWithError(error: String) {
        let alertVC = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertVC, animated: true)
        }
    }
    
    func didUpdateSearchRecipes(recipes: [SearchRecipe]) {
        DispatchQueue.main.async { [weak self] in
            self?.searchRecipes = recipes
            self?.tableView.reloadData()
        }
    }
    
    func didUpdateDetailRecipe(recipe: DetailRecipe) { }
    func didCuisinesRecipe(recipes: [CuisineRecipe]) { }
}
