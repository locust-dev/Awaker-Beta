//
//  CommonTableView.swift
//  Awaker
//
//  Created by Ilya Turin on 11.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonTableView: UITableView {
    
    // MARK: - Properties
    
    var isLoading = BehaviorSubject<Bool>(value: false)
    var loaderColor = BehaviorSubject<UIColor>(value: .blue)
    var refreshControlColor = BehaviorSubject<UIColor>(value: .blue)
    
    weak var refreshModuleOutput: RefreshControlModuleOutput?
    
    private let customRefreshControl = RefreshControl()
    private let loaderView = ProgressHUD()
    private let bag = DisposeBag()
    
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = .clear
        customRefreshControl.setupWith(view: self, moduleOutput: refreshModuleOutput)
        setupSubscriptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods
    
    private func setupSubscriptions() {
        
        isLoading.subscribe {
            self.setLoader($0.element)
        }.disposed(by: bag)
        
        loaderColor
            .bind(to: loaderView.rx.color)
            .disposed(by: bag)
    }
    
    private func setLoader(_ isLoading: Bool?) {
        
        guard isLoading == true else {
            loaderView.removeFromSuperview()
            customRefreshControl.finishedLoading()
            return
        }
        
        addSubview(loaderView)
        loaderView.autoAlignAxis(.vertical, toSameAxisOf: superview ?? self)
        loaderView.autoAlignAxis(.horizontal, toSameAxisOf: superview ?? self)
    }
    
}
