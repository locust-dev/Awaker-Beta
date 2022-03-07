//
//  UITableVIew+RegisterCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import UIKit

extension UITableView {
    
    func register(_ cellClass: Swift.AnyClass?) {
        
        guard let identifier = (cellClass as? NSObject.Type)?.className else {
            assertionFailure("Cannot get className from cellClass")
            return
        }
        
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func register(_ cellClasses: [Swift.AnyClass]) {
        cellClasses.forEach { register($0) }
    }
    
    func register(cellTypes: UITableViewCell.Type...) {
       
        cellTypes.forEach { (type) in
            let reuseIdentifier = String(describing: type)
            register(type, forCellReuseIdentifier: reuseIdentifier)
        }
        
    }
    
    func register(nibs: String...) {
        nibs.forEach { register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0) }
    }
    
}
