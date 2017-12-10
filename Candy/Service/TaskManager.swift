//
//  TaskManager.swift
//  Candy
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation

class TaskManager: NSObject {
    
    var todoCount: Int {
        return todoTasks.count
    }
    var doneCount: Int {
        return doneTasks.count
    }
    
    fileprivate var todoTasks = [Task]()
    fileprivate var doneTasks = [Task]()
    
    func addTask(_ task: Task){
        if !todoTasks.contains(task){
            todoTasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task{
        return todoTasks[index]
    }
    
    func markTaskDone(at index: Int){
        let task = todoTasks.remove(at: index)
        doneTasks.append(task)
    }
    
    func unMarkTaskDone(at index: Int){
        let task = doneTasks.remove(at: index)
        todoTasks.append(task)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
    
    func removeAll(){
        todoTasks.removeAll()
        doneTasks.removeAll()
    }
}

class TaskService {
    static let shared = TaskService()
    var taskManager = TaskManager()
}
