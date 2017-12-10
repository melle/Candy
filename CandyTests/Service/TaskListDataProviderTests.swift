//
//  TaskListDataProviderTests.swift
//  CandyTests
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import XCTest
@testable import Candy

class TaskListDataProviderTests: XCTestCase {
    
    var sut: TaskListDataProvider!
    var tableView: UITableView!
    var first: Task!
    var second: Task!
    
    override func setUp() {
        super.setUp()
        sut = TaskListDataProvider()
        sut.taskManager = TaskManager()
        let vc = ListVC()
        _ = vc.view
        tableView = vc.taskTableView
        tableView.dataSource = sut
        
        first = Task(title: "Foo", description: "Bar", timestamp: 0.0, priority: 1)
        second = Task(title: "Fezz", description: "Barz", timestamp: 0.0, priority: 1)
    }
    
    func testIfNumberOfSectionISTwo(){
        
        let numberOfSection = tableView.numberOfSections
        XCTAssertEqual(numberOfSection, 2)
    }
    
    func testForNumberofRowInSectionOneIsTaskToDoCount(){
        sut.taskManager?.addTask(first)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        sut.taskManager?.addTask(second)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
    
    func testForNumberofRowInSectionTwoIsTaskDoneCount(){
        sut.taskManager?.addTask(first)
        sut.taskManager?.addTask(second)
        sut.taskManager?.markTaskDone(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.markTaskDone(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testIfTaskTableViewCellReturns_TaskCell() {
        sut.taskManager?.addTask(first)
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIfCellIsDequeuedFromTableView(){
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        
        mockTableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        sut.taskManager?.addTask(first)
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    func testIfRowsCalledConfigCell(){
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        sut.taskManager?.addTask(first)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        
        XCTAssertEqual(cell.cachedTask, first)
    }
    
    func testIfCellRowWillCallDoneTasks(){
        let mockTableView = MockTableView(frame: CGRect(x: 0, y:0, width: 320, height: 480),
            style: .plain)
        mockTableView.dataSource = sut
        mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        sut.taskManager?.addTask(first)
        sut.taskManager?.addTask(second)
        mockTableView.reloadData()
        
        sut.taskManager?.markTaskDone(at: 1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        XCTAssertEqual(cell.cachedTask, second)
    }
    
    func testIfButtonMarksTaskAsDone(){
        sut.taskManager?.removeAll()
        sut.taskManager?.addTask(first)
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TaskCell
        cell.handlePriorityButtonClicked()
        
        XCTAssertEqual(sut.taskManager?.todoCount, 0)
        XCTAssertEqual(sut.taskManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func testIfButtonUnMarksTaskAsDone(){
        sut.taskManager?.removeAll()
        sut.taskManager?.addTask(first)
        sut.taskManager?.markTaskDone(at: 0)
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TaskCell
        cell.handlePriorityButtonClicked()
        
        XCTAssertEqual(sut.taskManager?.todoCount, 1)
        XCTAssertEqual(sut.taskManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
    
    func testIfCellRowWithDoneTaskReturnsTaskAsTrue(){
        let mockTableView = MockTableView(frame: CGRect(x: 0, y:0, width: 320, height: 480),
                                          style: .plain)
        mockTableView.dataSource = sut
        mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        sut.taskManager?.addTask(first)
        sut.taskManager?.addTask(second)
        mockTableView.reloadData()
        
        sut.taskManager?.markTaskDone(at: 1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        XCTAssertEqual(cell.checked, true)
    }
}

extension TaskListDataProviderTests{
    
    class MockTableView: UITableView {
        var cellIsDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockTaskCell: TaskCell {
        var cachedTask: Task?
        var checked: Bool?
        
        override func configCell(with task: Task, indexPath: IndexPath, checked: Bool) {
            cachedTask = task
            self.checked = checked
        }
    }
}
