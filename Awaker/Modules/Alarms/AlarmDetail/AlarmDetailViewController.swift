//
//  AlarmDetailViewController.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 19.03.2022.
//

import UIKit
import PureLayout

import RxSwift
import RxCocoa

final class AlarmDetailViewController: NLViewController {
    
    var viewModel: AlarmDetailViewModel?
    
    private let disposeBag = DisposeBag()
    
    private let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
        bind()
    }
    
    private func drawSelf() {
        
        view.setGradientBackground(with: [Colors.lightPurple(), Colors.darkPurple()], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        
        nameLabel.layer.cornerRadius = 10
        nameLabel.clipsToBounds = true
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 35, weight: .bold)
        nameLabel.textColor = Colors.darkPurple()
        view.addSubview(nameLabel)
        
        nameLabel.autoCenterInSuperview()
    }
    
    private func bind() {
        let input = AlarmDetailViewModel.Input()
        let output = viewModel?.transform(input: input)
        output?.name.drive(nameLabel.rx.text).disposed(by: disposeBag)
    }
    
}
