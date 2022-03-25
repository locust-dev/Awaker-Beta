//
//  AlarmDetailTableViewItem.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit

enum AlarmDetailTableViewItem {
    
    case name(configurator: TableCellConfigurator<AlarmNameCell, AlarmNameCell.Model>)
    case volume(configurator: TableCellConfigurator<AlarmVolumeCell, AlarmVolumeCell.Model>)
    case sound(configurator: TableCellConfigurator<AlarmTitleCell, AlarmTitleCell.Model>)
    case task(configurator: TableCellConfigurator<AlarmTitleCell, AlarmTitleCell.Model>)
    case repeatDelay(configurator: TableCellConfigurator<AlarmRepeatDelayCell, AlarmRepeatDelayCell.Model>)
    
    var configurator: TableCellConfiguratorProtocol {
        
        switch self {
            
        case .name(configurator: let configurator):
            return configurator
            
        case .volume(configurator: let configurator):
            return configurator
            
        case .sound(configurator: let configurator):
            return configurator
            
        case .task(configurator: let configurator):
            return configurator
            
        case .repeatDelay(configurator: let configurator):
            return configurator
        }
    }
    
    var identifier: String {
        return type(of: configurator).reuseId
    }
}
