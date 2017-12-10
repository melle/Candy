//
//  ItemManagerTests.swift
//  CandyTests
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import XCTest
@testable import Candy

class ItemManagerTests: XCTestCase {
    
    var sut: TaskManager!
    var first: Task!
    var second: Task!
    
    override func setUp() {
        super.setUp()
        sut = TaskManager()
        first = Task(title: "Foo", description: "Bar", timestamp: 0.0, priority: 1)
        second = Task(title: "Fezz", description: "Barz", timestamp: 0.0, priority: 1)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTaskCountIfItsIntiallyZero(){
        XCTAssertEqual(sut.todoCount, 0)
    }
    
    func testTasDonekCountIfItsIntiallyZero(){
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func testAddTaskIncreasesTodoCount(){
        sut.addTask(first)
        XCTAssertEqual(sut.todoCount, 1)
    }
    
    func testIfItemAddedToTaskIsTheItemReturned(){
        sut.addTask(first)
        let returnedItem = sut.task(at: 0)
        XCTAssertEqual(returnedItem.title, "Foo")
    }
    
    func testCheckIfATaskHasBeenMarkedDone(){
        sut.addTask(first)
        sut.addTask(second)
        sut.markTaskDone(at: 0)
        
        XCTAssertEqual(sut.task(at: 0).title, "Fezz")
        XCTAssertEqual(sut.todoCount, 1)
    }
    
    func testDoneTasksReturnItemAtTheIndexProvided(){
        sut.addTask(first)
        sut.addTask(second)
        
        sut.markTaskDone(at: 0)
        
        let returnedTask = sut.doneTask(at: 0)
        XCTAssertEqual(returnedTask, first)
    }
    
    func testEqualTasksAreNotEqual(){
        XCTAssertNotEqual(first, second)
    }
    
    func testRemoveAllTask(){
        sut.addTask(first)
        sut.addTask(second)
        
        sut.markTaskDone(at: 0)
        
        XCTAssertEqual(sut.todoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAll()
        
        XCTAssertEqual(sut.todoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func testThatTaskWithTheSameTitleDontAdd(){
        sut.addTask(first)
        sut.addTask(Task(title: "Foo", description: "Bar", timestamp: 0.0, priority: 1))
        XCTAssertEqual(sut.todoCount, 1)
    }
}
