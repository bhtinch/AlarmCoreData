//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Benjamin Tincher on 1/21/21.
//

import UIKit

protocol IsEnabledStatusDelegate: AnyObject {
    func updateIsEnabledStatus(_ sender: UITableViewCell)
}

class AlarmTableViewCell: UITableViewCell {
    //  Outlets
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var fireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    weak var delegate: IsEnabledStatusDelegate?
    
    //  Actions
    @IBAction func isEnabledSwitchChanged(_ sender: Any) {
        delegate?.updateIsEnabledStatus(self)
    }
    
    func updateViews(alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        fireDateLabel.text = alarm.fireDate?.dateToString(format: .fullNumericTimestamp)
        isEnabledSwitch.isOn = alarm.isEnabled
    }
}
