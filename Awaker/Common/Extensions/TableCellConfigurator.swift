//
//  TableCellConfigurator.swift
//  FinchLists
//
//  Created by Vladimir Pchelyakov on 06.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

struct TableCellConfigurator<CellType: Configurable, Model>: TableCellConfiguratorProtocol
where CellType.Model == Model, CellType: UITableViewCell {
    
    // MARK: - Properties
    
    static var reuseId: String {
        String(describing: CellType.self)
    }
    
    var cellHeight: CGFloat
    var headerHeight: CGFloat
    
    let item: Model?
    
    
    // MARK: - Init
    
    init(item: Model?,
         cellHeight: CGFloat = UITableView.automaticDimension,
         headerHeight: CGFloat = UITableView.automaticDimension) {
        
        self.item = item
        self.cellHeight = cellHeight
        self.headerHeight = headerHeight
    }
    
    
    // MARK: - Public methods
    
    func configure(cell: UIView) {
        
        if let item = item {
            (cell as? CellType)?.configure(with: item)
        }
    }
    
    func associatedValue<T>() -> T? {
        item as? T
    }
    
}
