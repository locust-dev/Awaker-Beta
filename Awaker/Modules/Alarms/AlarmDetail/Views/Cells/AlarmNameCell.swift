//
//  AlarmNameCell.swift
//  Awaker
//
//  Created by Ilya Turin on 25.03.2022.
//

import UIKit
import PureLayout

import RxSwift
import RxCocoa

final class AlarmNameCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let textView = UITextView()
    private var disposeBag: DisposeBag?
    
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = nil
    }
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 18)
    
        contentView.addSubview(textView)
        textView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}

extension AlarmNameCell: Configurable {
    
    struct Model {
    
        let name: BehaviorSubject<String?>
    }
    
    func configure(with model: Model) {
        
        let disposeBag = DisposeBag()
        
        model.name
            .subscribe(onNext: { self.textView.text = $0 })
            .disposed(by: disposeBag)
        
        textView.rx.text
            .bind(to: model.name)
            .disposed(by: disposeBag)
        
        self.disposeBag = disposeBag
    }
}
