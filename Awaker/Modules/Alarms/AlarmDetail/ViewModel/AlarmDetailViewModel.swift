//
//  AlarmDetailViewModel.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 19.03.2022.
//

import RxSwift
import RxCocoa

final class AlarmDetailViewModel {
    
    // MARK: - Properties
    
    var router: AlarmDetailRouterInput?
    
    var newAlarm: PublishSubject<Alarm>?
    
    private var alarm: Alarm
    private let initialAlarmName: String?
    
    private let tableViewItems = PublishSubject<[AlarmDetailTableViewItem]>()
    private let volumeSliderValue = PublishSubject<Float>()
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    init(alarm: Alarm? = nil) {
        
        guard let alarm = alarm else {
            let emptyAlarm = Alarm()
            self.alarm = emptyAlarm
            self.initialAlarmName = emptyAlarm.name
            return
        }

        self.alarm = alarm
        self.initialAlarmName = alarm.name
    }
    
    
    // MARK: - Public methods
    
    func createCells() {
        
        typealias Item = AlarmDetailTableViewItem
        
        typealias VolumeCellConfigurator = TableCellConfigurator<AlarmVolumeCell, AlarmVolumeCell.Model>
        let volumeRowModel = AlarmVolumeCell.Model(title: "Громкость", sliderValue: volumeSliderValue)
        let volumeRowConfigurator = VolumeCellConfigurator(item: volumeRowModel)
        let volumeRowItem = Item.volume(configurator: volumeRowConfigurator)
        
        typealias SoundCellConfigurator = TableCellConfigurator<AlarmTitleCell, AlarmTitleCell.Model>
        let soundRowModel = AlarmTitleCell.Model(title: "Мелодия")
        let soundRowConfigurator = SoundCellConfigurator(item: soundRowModel)
        let soundRowItem = Item.sound(configurator: soundRowConfigurator)
        
        typealias TaskCellConfigurator = TableCellConfigurator<AlarmTitleCell, AlarmTitleCell.Model>
        let taskRowModel = AlarmTitleCell.Model(title: "Задача")
        let taskRowConfigurator = TaskCellConfigurator(item: taskRowModel)
        let taskRowItem = Item.task(configurator: taskRowConfigurator)
        
        typealias RepeatDelayCellConfigurator = TableCellConfigurator<AlarmRepeatDelayCell, AlarmRepeatDelayCell.Model>
        let repeatDelayRowModel = AlarmRepeatDelayCell.Model(title: "Повтор сигнала")
        let repeatDelayRowConfigurator = RepeatDelayCellConfigurator(item: repeatDelayRowModel)
        let repeatDelayRowItem = Item.repeatDelay(configurator: repeatDelayRowConfigurator)
        
        let items = [
            volumeRowItem,
            soundRowItem,
            repeatDelayRowItem,
            taskRowItem
        ]
        
        tableViewItems.onNext(items)
        tableViewItems.onCompleted()
    }
  
}


//MARK: - ViewModelType
extension AlarmDetailViewModel: ViewModelType {
    
    struct Input {
        let name: Observable<String?>
        let time: Observable<Date>
        let activeDays: Observable<[WeekDay]>
        let terminateMethod: Observable<TerminateMethod?>
        let sound: Observable<Sound>
        let closeButtonTap: Driver<Void>
        let saveButtonTap: Driver<Void>
    }
    
    struct Output {
        let initialAlarmName: Driver<String?>
        let cells: Driver<[AlarmDetailTableViewItem]>
    }
    
    func transform(input: Input) -> Output {
        
        volumeSliderValue
            .subscribe(onNext: { self.alarm.volume = $0})
            .disposed(by: disposeBag)
        
        input.closeButtonTap
            .drive(onNext: { self.router?.dismiss() })
            .disposed(by: disposeBag)
        
        input.name
            .subscribe(onNext: { self.alarm.name = $0 })
            .disposed(by: disposeBag)
        
        input.time
            .subscribe(onNext: { self.alarm.time = $0 })
            .disposed(by: disposeBag)
        
        input.activeDays
            .subscribe(onNext: { self.alarm.activeDays = $0 })
            .disposed(by: disposeBag)
        
        input.terminateMethod
            .subscribe(onNext: { self.alarm.terminateMethod = $0 })
            .disposed(by: disposeBag)
        
        input.sound
            .subscribe(onNext: { self.alarm.sound = $0 })
            .disposed(by: disposeBag)
        
        input.saveButtonTap
            .drive(onNext: { [router] in
                self.newAlarm?.onNext(self.alarm)
                router?.dismiss()
            })
            .disposed(by: disposeBag)
        
        let cells = tableViewItems.asDriver(onErrorJustReturn: [])
        let initialAlarmName = Observable.just(initialAlarmName).asDriver(onErrorJustReturn: nil)
       
        return Output(initialAlarmName: initialAlarmName, cells: cells)
    }
    
}
