//
//  RefreshControl.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

import UIKit
import SwiftUI

protocol RefreshControlModuleInput: AnyObject {
    
    func setupWith(view: UIScrollView, moduleOutput: RefreshControlModuleOutput?)
    func finishedLoading()
}

protocol RefreshControlModuleOutput: AnyObject {
    
    func didRefresh()
}


final class RefreshControl: UIRefreshControl {
    
    // MARK: - Properties
    
    private weak var outputModule: RefreshControlModuleOutput?
    
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        tintColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - RefreshControlModuleInput
extension RefreshControl: RefreshControlModuleInput {
    
    @objc private func didRefresh() {
        outputModule?.didRefresh()
    }
    
    func setupWith(view: UIScrollView, moduleOutput: RefreshControlModuleOutput?) {
        outputModule = moduleOutput
        view.refreshControl = self
        addTarget(self, action: #selector(didRefresh), for: .valueChanged)
    }
    
    func finishedLoading() {
        mainQueue(delay: 1) {
            self.endRefreshing()
        }
    }
    
}
