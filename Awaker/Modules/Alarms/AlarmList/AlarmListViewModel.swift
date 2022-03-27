//
//  AlarmListViewModel.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 11.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class AlarmListViewModel {

    // MARK: - Properties

    var router: AlarmListRouterInput?
    
    let newAlarm = PublishSubject<Alarm>()
    
    var alarms: [Alarm] = []
    
    let cells = PublishSubject<[Alarm]>()
    
    let title = PublishSubject<String?>()
    let subtitle = PublishSubject<String?>()
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Public methods
    
    func transform(input: Input) -> Output {
        input.selectedCellIndex
            .drive(onNext: { indexPath in
                if let alarm = self.alarms[safe: indexPath.row] {
                    self.router?.openAlarmDetail(with: alarm)
                }
            })
            .disposed(by: disposeBag)
        
        input.addButtonTap
            .drive(onNext: { [router] in
                router?.openAlarmDetail(newAlarm: self.newAlarm)
            })
            .disposed(by: disposeBag)
        
        newAlarm.subscribe {
            if let alarm = $0.element {
                self.alarms.append(alarm)
                self.alarms = self.alarms.sorted(by: {$0.time < $1.time})
                if let (hours, minutes) = self.calculateTimeToFirstAlarm() {
                    self.title.onNext("Звонит через \(hours) часов \(minutes) мин")
                    self.subtitle.onNext(self.getSubtitle())
                }
                self.cells.onNext(self.alarms)
            }
        }.disposed(by: disposeBag)
        
        return Output(cellModels: cells.asDriver(onErrorJustReturn: []),
                      title: title.asDriver(onErrorJustReturn: nil),
                      subtitle: subtitle.asDriver(onErrorJustReturn: nil))
    }
    
    private func calculateTimeToFirstAlarm() -> (Int, Int)? {
        if let alarmTime = alarms.first?.time {
            let differenceBetweenNowAndFirstAlarm = Date().differenceBetween(toDate: alarmTime)
            let hour = differenceBetweenNowAndFirstAlarm.hour! + differenceBetweenNowAndFirstAlarm.day! * 24
            let minute = differenceBetweenNowAndFirstAlarm.minute!
            return (hour, minute)
        } else {
            return nil
        }
    }
    
    private func getSubtitle() -> String? {
        if let hour = alarms.first?.time.hour {
            var subtitle = "Сработает завтра "
            switch hour {
                
            case 0..<6:
                subtitle += "ночью"
                
            case 6..<12:
                subtitle += "утром"
                
            case 12..<18:
                subtitle += "днем"
                
            case 18..<24:
                subtitle += "вечером"
                
            default:
                break
            }
            
            return subtitle
        } else {
            return nil
        }
    }
    
}

extension AlarmListViewModel {
    
    struct Input {
        let selectedCellIndex: Driver<IndexPath>
        let addButtonTap: Driver<Void>
    }
    
    struct Output {
        let cellModels: Driver<[Alarm]>
        let title: Driver<String?>
        let subtitle: Driver<String?>
    }
    
}
