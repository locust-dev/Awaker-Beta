//
//  CellConfigurator.swift
//  FinchLists
//
//  Created by Vladimir Pchelyakov on 06.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

protocol ViewConfigurator {
    
    static var reuseId: String { get }
    
    func configure(cell: UIView)
    func associatedValue<T>() -> T?
    
}


// MARK: - Table

protocol TableHeaderFooterConfiguratorProtocol: ViewConfigurator {
    var viewHeight: CGFloat { get }
}

protocol TableCellConfiguratorProtocol: ViewConfigurator {
    var cellHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
}


// MARK: - Collection

protocol CollectionCellConfiguratorProtocol: ViewConfigurator {
    var size: CGSize { get }
}
