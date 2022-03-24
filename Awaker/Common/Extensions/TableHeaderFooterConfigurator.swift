//
//  TableHeaderFooterConfigurator.swift
//  FinchLists
//
//  Created by VadimQw  on 15.06.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

struct TableHeaderFooterConfigurator<ViewType: Configurable, Model>: TableHeaderFooterConfiguratorProtocol
where ViewType.Model == Model, ViewType: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static var reuseId: String {
        String(describing: ViewType.self)
    }
    
    var viewHeight: CGFloat
    
    let item: Model?
    
    
    // MARK: - Init
    
    init(item: Model?, viewHeight: CGFloat = UITableView.automaticDimension) {
        self.item = item
        self.viewHeight = viewHeight
    }
    
    
    // MARK: - Public methods
    
    func configure(cell: UIView) {
        
        if let item = item {
            (cell as? ViewType)?.configure(with: item)
        }
    }
    
    func associatedValue<T>() -> T? {
        item as? T
    }
    
}
