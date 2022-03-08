//
//  CollectionViewManagerInput.swift
//  FinchLists
//
//  Created by Vladimir Pchelyakov on 06.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

protocol CollectionViewManagerInput: AnyObject {
    
    func setup(collectionView: UICollectionView, delegate: AnyObject?)
    func update<ViewModel>(viewModel: ViewModel)
    
}
