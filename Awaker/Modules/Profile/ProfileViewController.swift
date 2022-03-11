//
//  ProfileViewController.swift
//  Awaker
//
//  Created by Ilya Turin on 09.03.2022.
//

import UIKit
import RxSwift

final class ProfileViewController: NLViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
       
        view.backgroundColor = .white
        
        view.addSubview(tableView)
       
    }
    
}
