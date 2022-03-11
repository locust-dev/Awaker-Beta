//
//  AlarmsViewController.swift
//  Awaker
//
//  Created by Ilya Turin on 10.03.2022.
//

import UIKit

final class AlarmsViewController: NLViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .yellow
        
    }
    
}
