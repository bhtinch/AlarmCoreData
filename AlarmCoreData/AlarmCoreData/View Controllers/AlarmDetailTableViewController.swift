//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Benjamin Tincher on 1/21/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    //  Outlets
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var isEnabledButton: UIButton!
    
    var alarm: Alarm?
    var isEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //  Actions
    @IBAction func alarmDatePickerChanged(_ sender: Any) {
        
    }
    
    @IBAction func isEnabledButtonTapped(_ sender: Any) {
        isEnabled.toggle()
        updateIsEnabledButtonApperance()
        if let alarm = alarm { AlarmController.shared.toggleIsEnabledStatusOf(alarm: alarm) }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, !title.isEmpty else { return }
       
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, title: title, fireDate: alarmDatePicker.date, isEnabled: isEnabled)
        } else {
            AlarmController.shared.createAlarmWith(title: title, fireDate: alarmDatePicker.date, isEnabled: isEnabled)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func updateViews() {
        if let alarm = alarm {
            alarmDatePicker.date = alarm.fireDate ?? Date()
            alarmTitleTextField.text = alarm.title
            isEnabled = alarm.isEnabled
            updateIsEnabledButtonApperance()
        }
    }
    
    func updateIsEnabledButtonApperance() {
        if isEnabled {
            isEnabledButton.setTitleColor(.systemOrange, for: .normal)
            isEnabledButton.backgroundColor = .black
            isEnabledButton.setTitle("ON", for: .normal)
        } else {
            isEnabledButton.setTitleColor(.black, for: .normal)
            isEnabledButton.backgroundColor = .systemGray
            isEnabledButton.setTitle("OFF", for: .normal)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
