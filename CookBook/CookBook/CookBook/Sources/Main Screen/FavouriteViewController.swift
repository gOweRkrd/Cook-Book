import UIKit

final class FavouriteViewController: UIViewController {
    
    private let tableView = UITableView()
    private let identifier = "MyCell"
    private let storageManager = StorageManager.shared
    private lazy var emptyStateView = EmptyStateView()
    private var favoriteItems = [Recipe]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        createTable()
        showEmptyStateView()
        
        emptyStateView.frame = view.frame
        view.addSubview(emptyStateView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteItems = storageManager.fetchItems()
        tableView.reloadData()
        
        if favoriteItems.isEmpty {
            showEmptyStateView()
        } else {
            removeEmptyStateView()
        }
    }
  
    // MARK: - Setup
    
    private func createTable() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.backgroundColor = .backgroundColor
    }
    
    private func showEmptyStateView() {
        view.bringSubviewToFront(emptyStateView)
        
    }
    
    private func removeEmptyStateView() {
        view.bringSubviewToFront(tableView)
        
    }
}

// MARK: - TableView DataSource

extension FavouriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        
        let recipe = favoriteItems[indexPath.row]
        
        cell.setup(title: recipe.title, imageUrl: recipe.image)
        cell.backgroundColor = .backgroundColor
        return cell
    }
}

// MARK: - TableView Delegate

extension FavouriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailViewController()
        detailVC.id = Int(favoriteItems[indexPath.row].id)
        detailVC.isFavorite = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = favoriteItems[indexPath.row]
            storageManager.delete(recipe)
            favoriteItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if favoriteItems.isEmpty {
                showEmptyStateView()
            } else {
                removeEmptyStateView()
            }
        }
    }
}
