//
//  AlarmRepeatDelayPicker.swift
//  Awaker
//
//  Created by Ilya Turin on 26.03.2022.
//

import UIKit
import PureLayout
import RxSwift

final class AlarmRepeatDelayPicker: NLView {
    
    // MARK: - Properties
    
    let selectedDelay = PublishSubject<Int?>()
    
    private var initialDateSubscription: Disposable?
    
    private let pickerView = UIPickerView()
    private let elements = ["Выкл.", 5, 10, 15] as [Any]
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        setupSubscriptions()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)
        pickerView.autoPinEdgesToSuperviewEdges()
    }
    
    private func setupSubscriptions() {
        
        initialDateSubscription = selectedDelay.subscribe(onNext: { delay in
            
            guard let delay = delay else {
                self.pickerView.selectRow(0, inComponent: 0, animated: true)
                return
            }
            
            switch delay {
                
            case 5:
                self.pickerView.selectRow(1 , inComponent: 0, animated: true)
            case 10:
                self.pickerView.selectRow(2 , inComponent: 0, animated: true)
            case 15:
                self.pickerView.selectRow(3 , inComponent: 0, animated: true)
            default:
                break
            }
            
            self.initialDateSubscription?.dispose()
        })
    }
    
}


extension AlarmRepeatDelayPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let number = elements[row] as? Int else {
            selectedDelay.onNext(nil)
            return
        }
        
        selectedDelay.onNext(number)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        elements.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = MainFont.regular.withSize(20)
        
        label.text = "\(elements[row])"
        
        return label
    }
}
