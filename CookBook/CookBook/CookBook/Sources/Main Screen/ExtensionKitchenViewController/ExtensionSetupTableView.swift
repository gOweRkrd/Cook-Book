import UIKit

extension KitchenViewController {
    
    func setupTableView() {
        
        myTableView.backgroundColor = .backgroundColor
        myTableView.rowHeight = 230
        
        myTableView.register(MyOwnCell.self, forCellReuseIdentifier: "CellID")
        myTableView.dataSource = self
        myTableView.delegate = self
    }
}
