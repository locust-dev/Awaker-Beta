//
//  AlarmDetailRouter.swift
//  Awaker
//
//  Created by Ilya Turin on 24.03.2022.
//

protocol AlarmDetailRouterInput: AnyObject {
    func dismiss()
    func applyAlarmChanges(_ alarm: Alarm)
}

final class AlarmDetailRouter {
    
    // MARK: - Properties
    
    private unowned let view: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(view: ModuleTransitionHandler) {
        self.view = view
    }
    
}


// MARK: - AlarmDetailRouterInput
extension AlarmDetailRouter: AlarmDetailRouterInput {
    
    func dismiss() {
        view.dismiss(animated: true)
    }
    
    func applyAlarmChanges(_ alarm: Alarm) {
        
        print(alarm)
        dismiss()
    }
}
