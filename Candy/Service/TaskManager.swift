//
//  TaskManager.swift
//  Candy
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation
import RealmSwift

class TaskManager: NSObject {
    
    let dateFormatter = DateFormatter()
    
    let realm = try! Realm()
    var todos: Results<Task>!
    
    var todoCount: Int {
        return todoTasks?.count ?? 0
    }
    var doneCount: Int {
        return doneTasks?.count ?? 0
    }
    
    var todoTasks: Results<Task>?
    var doneTasks: Results<Task>?
    
    var groupedTasks = [[Task]]()
    
    func fetchTaskForToday(){
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: Date())
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom)
        components.day! += 1
        let dateTo = calendar.date(from: components)!
        let datePredicate = NSPredicate(format: "(%@ <= timestamp) AND (timestamp < %@)", argumentArray: [dateFrom, dateTo])
        todos = realm.objects(Task.self).filter(datePredicate)
        doneTasks = self.todos.filter("isChecked = true")
        todoTasks = self.todos.filter("isChecked = false")
    }
    
    func sortTodayTaskByPriority(value: Bool) {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: Date())
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom)
        components.day! += 1
        let dateTo = calendar.date(from: components)!
        let datePredicate = NSPredicate(format: "(%@ <= timestamp) AND (timestamp < %@)", argumentArray: [dateFrom, dateTo])
        todos = realm.objects(Task.self).filter(datePredicate).sorted(byKeyPath: "priority", ascending: value)
        doneTasks = self.todos.filter("isChecked = true")
        todoTasks = self.todos.filter("isChecked = false")
    }
    
    func groupTaskByDate(){
        let results = realm.objects(Task.self)
        let taskArrays = Array<Task>(results)
        groupedTasks = taskArrays.groupBy{$0.timestamp}
        
        let datesArray = taskArrays.flatMap { $0.timestamp } // return array of date
        var dic = [String:[[String:Any]]]() // Your required result
        datesArray.forEach {
            let dateKey = $0
            let filterArray = yourArray.filter { $0["date"] as? String == dateKey }
            dic[$0] = filterArray
        }
    }
    
    func addTask(_ task: Task){
        try! realm.write {
            realm.add(task)
            fetchTaskForToday()
        }
    }
    
    func task(at index: Int) -> Task{
        return todoTasks![index]
    }
    
    func markTaskDone(at index: Int){
        try! self.realm.write{
            todoTasks![index].isChecked = true
        }
    }
    
    func unMarkTaskDone(at index: Int){
        try! self.realm.write{
            doneTasks![index].isChecked = false
        }
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks![index]
    }
    
    func deleteTask(task: Task) {
        try! self.realm.write{
            self.realm.delete(task)
        }
    }
    
    func removeAll(){
        //todoTasks.removeAll()
        //doneTasks.removeAll()
    }
}

class TaskService {
    static let shared = TaskService()
    var taskManager = TaskManager()
    
    func getTodayTaskManager() -> TaskManager {
        taskManager.fetchTaskForToday()
        return taskManager
    }
    
    func getTodaySortTaskManager(value: Bool) -> TaskManager {
        taskManager.sortTodayTaskByPriority(value: value)
        return taskManager
    }
    
    func getAllTaskGroupedByDate() -> TaskManager {
        taskManager.groupTaskByDate()
        return taskManager
    }
}

