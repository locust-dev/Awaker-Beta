//
//  UICollectionView.swift
//  Stoloto
//
//  Created by Beniamin Sarkisyan on 23/02/2017.
//  Copyright © 2017 Goodworkapps. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: - Public methods
    
    func reloadData(completion: @escaping () -> Void) {
        
        mainQueue {
            UIView.animate(withDuration: 0, animations: {
                self.reloadData()
            }) { _ in
                completion()
            }
        }
    }
    
    func registerHeaders(headerTypes: UICollectionReusableView.Type...) {
        
        headerTypes.forEach {
            register(
                $0,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: $0.className
            )
        }
    }
    
    func registerCells(cellTypes: UICollectionViewCell.Type...) {
        
        cellTypes.forEach {
            register($0, forCellWithReuseIdentifier: $0.className)
        }
    }
    
    func getLastIndexPath() -> IndexPath {
        
        let lastSectionIndex = max(0, numberOfSections - 1)
        let lastRowIndex = max(0, numberOfItems(inSection: lastSectionIndex) - 1)
        return IndexPath(row: lastRowIndex, section: lastSectionIndex)
    }
    
}
