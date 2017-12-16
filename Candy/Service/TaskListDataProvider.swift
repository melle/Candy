//
//  TaskListDataProvider.swift
//  Candy
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

@objc protocol TaskManagerSettable {
    var taskManager: TaskManager? { get set }
}

enum Section: Int {
    case todo
    case done
}

class TaskListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate, TaskManagerSettable {
    
    var taskManager: TaskManager?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let taskManager = taskManager else {return 0}
        
        guard let itemSection = Section(rawValue: section) else{
            fatalError()
        }
        let numberOfRows: Int
        switch itemSection {
        case .todo:
            numberOfRows = taskManager.todoCount
        case .done:
            numberOfRows = taskManager.doneCount
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        guard let taskManger = taskManager else{
            fatalError()
        }
        
        guard let section = Section(rawValue: indexPath.section) else {fatalError()}
        
        let task: Task
        var checked = false
        switch section {
        case .todo:
            checked = false
            task = taskManger.task(at: indexPath.item)
        case .done:
            checked = true
            task = taskManger.doneTask(at: indexPath.item)
        }
        
        cell.configCell(with: task, indexPath: indexPath, checked: checked)
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension TaskListDataProvider: TaskDelegate {
    
    func deleteTask(indexPath: IndexPath) {
        guard let taskManager = taskManager else {fatalError()}
        guard let section = Section(rawValue: indexPath.section)else {fatalError()}
        switch section {
        case .todo:
            let task = taskManager.todoTasks![indexPath.row]
            taskManager.deleteTask(task: task)
        case .done:
            let task = taskManager.doneTasks![indexPath.row]
            taskManager.deleteTask(task: task)
        }
        NotificationCenter.default.post(name: .reloadListVC, object: nil)
    }
    
    func markTaskAsDone(indexPath: IndexPath) {
        guard let taskManager = taskManager else {fatalError()}
        guard let section = Section(rawValue: indexPath.section)else {fatalError()}
        switch section {
        case .todo:
            taskManager.markTaskDone(at: indexPath.row)
        case .done:
            taskManager.unMarkTaskDone(at: indexPath.row)
        }
        NotificationCenter.default.post(name: .reloadListVC, object: nil)
    }
    
    func editTask(indexPath: IndexPath) {
        
    }
}
