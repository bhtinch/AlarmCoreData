//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Benjamin Tincher on 1/21/21.
//

import CoreData

class AlarmController {
    
    static var shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
       let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //  Create
    func createAlarmWith(title: String, fireDate: Date, isEnabled: Bool) {
        let alarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        alarms.append(alarm)
        CoreDataStack.saveContext()
    }
    
    //  Read(fetch)
    func fetchAlarms() {
        alarms = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    //  Update
    func update(alarm: Alarm, title: String, fireDate: Date, isEnabled: Bool) {
        alarm.title = title
        alarm.fireDate = fireDate
        alarm.isEnabled = isEnabled
        CoreDataStack.saveContext()
    }
    
    func toggleIsEnabledStatusOf(alarm: Alarm) {
        alarm.isEnabled.toggle()
        CoreDataStack.saveContext()
    }
    
    //  Delete
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        CoreDataStack.context.delete(alarm)
        CoreDataStack.saveContext()
    }
}   //  End of Class
