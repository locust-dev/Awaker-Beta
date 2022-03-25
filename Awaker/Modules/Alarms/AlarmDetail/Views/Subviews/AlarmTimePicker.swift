//
//  AlarmTimePicker.swift
//  Awaker
//
//  Created by Ilya Turin on 25.03.2022.
//

import UIKit
import PureLayout
import RxSwift
import RxCocoa

final class AlarmTimePicker: NLView {
    
    // MARK: - Properties
    
    let selectedTime = PublishSubject<Date>()
    
    private var initialDateSubscription: Disposable?
    private var initalHour = 0
    private var initalMinute = 0
    
    private let pickerView = UIPickerView()
    private let hours = Array(0...23)
    private let minutes = Array(0...59)
    
    private let disposeBag = DisposeBag()
    
    
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
    
    
    // MARK: - Private methods
    
    private func setupSubscriptions() {

        initialDateSubscription = selectedTime.subscribe(onNext: { date in
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: date)
            
            guard let hour = components.hour, let minute = components.minute else {
                return
            }
            
            self.pickerView.selectRow(hour, inComponent: 0, animated: true)
            self.pickerView.selectRow(minute, inComponent: 2, animated: true)
            self.initalHour = hour
            self.initalMinute = minute
            
            self.initialDateSubscription?.dispose()
        })
    }
}


extension AlarmTimePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0: initalHour = row
        case 2: initalMinute = row
        default: break
        }
        
        let currentDate = Date()
        
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
        dateComponents.hour = initalHour
        dateComponents.minute = initalMinute
        
        guard let nextDate = Calendar.current.nextDate(after: currentDate,
                                                       matching: dateComponents,
                                                       matchingPolicy: .nextTime)
        else {
            return 
        }
       
        selectedTime.onNext(nextDate)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        component == 1 ? 30 : (bounds.width - 30) / 2
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hours.count
        case 1: return 1
        case 2: return minutes.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 82
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 64)
        
        switch component {
        
        case 0:
            label.text = hours[row].addZeroIfNeeded()
            label.textAlignment = .right
            
        case 1:
            label.text = ":"
            label.textAlignment = .center
            
        case 2:
            label.text = minutes[row].addZeroIfNeeded()
            label.textAlignment = .left
            
        default:
            break
        }
        
        return label
    }
}


private extension Int {
    
    func addZeroIfNeeded() -> String {
        
        switch self {
            
        case 0...9:
            return "0\(self)"
            
        default:
            return "\(self)"
        }
    }
}
