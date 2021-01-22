//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Benjamin Tincher on 1/21/21.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AlarmController.shared.fetchAlarms()
        tableView.reloadData()
    }
    
    //  Actions
    @IBAction func addAlarmButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self
        cell.updateViews(alarm: alarm)

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AlarmController.shared.delete(alarm: AlarmController.shared.alarms[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetailTVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? AlarmDetailTableViewController else { return }
            destination.alarm = AlarmController.shared.alarms[indexPath.row]
        }
    }
}

extension AlarmListTableViewController: IsEnabledStatusDelegate {
    func updateIsEnabledStatus(_ sender: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleIsEnabledStatusOf(alarm: alarm)
        self.tableView.reloadData()
    }
}
