import UIKit

extension KitchenViewController {
    
    func setupConstraints() {
        view.addSubviews([
            headerView,
            myTableView
        ])

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: .headerViewHeightAnchor),
            
            myTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:.myTableViewTrailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    
    static let myTableViewTrailingAnchor : CGFloat = 100
    static let headerViewHeightAnchor : CGFloat = 250
    
}
