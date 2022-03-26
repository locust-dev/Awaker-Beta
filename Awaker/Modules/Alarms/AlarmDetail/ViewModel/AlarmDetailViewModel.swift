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
    
    private var alarm: Alarm
    
    private let tableViewItems = PublishSubject<[AlarmDetailTableViewItem]>()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Cell binders
    
    private let volumeSliderValue: BehaviorSubject<Float>
    private let alarmName: BehaviorSubject<String?>
    
    
    // MARK: - Init
    
    init(alarm: Alarm? = nil) {
        
        guard let alarm = alarm else {
            let emptyAlarm = Alarm()
            self.alarm = emptyAlarm
            alarmName = BehaviorSubject(value: emptyAlarm.name)
            volumeSliderValue = BehaviorSubject(value: emptyAlarm.volume)
            return
        }

        self.alarm = alarm
        alarmName = BehaviorSubject(value: alarm.name)
        volumeSliderValue = BehaviorSubject(value: alarm.volume)
    }
    
    
    // MARK: - Public methods
    
    func createCells() {
        
        typealias Item = AlarmDetailTableViewItem
        
        typealias VolumeCellConfigurator = TableCellConfigurator<AlarmVolumeCell, AlarmVolumeCell.Model>
        let volumeRowModel = AlarmVolumeCell.Model(sliderValue: volumeSliderValue)
        let volumeRowConfigurator = VolumeCellConfigurator(item: volumeRowModel)
        let volumeRowItem = Item.volume(configurator: volumeRowConfigurator)
        
        typealias SoundCellConfigurator = TableCellConfigurator<AlarmTitleCell, AlarmTitleCell.Model>
        let soundRowModel = AlarmTitleCell.Model(title: "Мелодия (в разработке)")
        let soundRowConfigurator = SoundCellConfigurator(item: soundRowModel)
        let soundRowItem = Item.sound(configurator: soundRowConfigurator)
        
        typealias TaskCellConfigurator = TableCellConfigurator<AlarmTitleCell, AlarmTitleCell.Model>
        let taskRowModel = AlarmTitleCell.Model(title: "Задача (в разработке)")
        let taskRowConfigurator = TaskCellConfigurator(item: taskRowModel)
        let taskRowItem = Item.task(configurator: taskRowConfigurator)
        
        typealias RepeatDelayCellConfigurator = TableCellConfigurator<AlarmRepeatDelayCell, AlarmRepeatDelayCell.Model>
        let repeatDelayRowModel = AlarmRepeatDelayCell.Model()
        let repeatDelayRowConfigurator = RepeatDelayCellConfigurator(item: repeatDelayRowModel)
        let repeatDelayRowItem = Item.repeatDelay(configurator: repeatDelayRowConfigurator)
        
        typealias NameCellConfigurator = TableCellConfigurator<AlarmNameCell, AlarmNameCell.Model>
        let nameRowModel = AlarmNameCell.Model(name: alarmName)
        let nameRowConfigurator = NameCellConfigurator(item: nameRowModel)
        let nameRowItem = Item.name(configurator: nameRowConfigurator)
        
        let items = [
            nameRowItem,
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
        let time: Observable<Date>
        let activeDays: Observable<[WeekDay]>
        let terminateMethod: Observable<TerminateMethod?>
        let sound: Observable<Sound>
        let closeButtonTap: Driver<Void>
        let saveButtonTap: Driver<Void>
    }
    
    struct Output {
        let alarm: Observable<Alarm>
        let cells: Driver<[AlarmDetailTableViewItem]>
    }
    
    func transform(input: Input) -> Output {
        
        alarmName
            .subscribe(onNext: { self.alarm.name = $0 })
            .disposed(by: disposeBag)
        
        volumeSliderValue
            .subscribe(onNext: { self.alarm.volume = $0 })
            .disposed(by: disposeBag)
        
        input.activeDays
            .subscribe(onNext: { self.alarm.activeDays = $0 })
            .disposed(by: disposeBag)
        
        input.closeButtonTap
            .drive(onNext: { self.router?.dismiss() })
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
                router?.applyAlarmChanges(self.alarm)
            })
            .disposed(by: disposeBag)
        
        return Output(alarm: Observable.just(alarm),
                      cells: tableViewItems.asDriver(onErrorJustReturn: []))
    }
    
}
