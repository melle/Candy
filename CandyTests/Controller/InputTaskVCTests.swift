//
//  InputTaskVCTests.swift
//  CandyTests
//
//  Created by SimpuMind on 12/10/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import XCTest
@testable import Candy

class InputTaskVCTests: XCTestCase {
    
    let sut = InputTaskVC()
    
    override func setUp() {
        super.setUp()
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSaveTaskItem(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
        
        let timestamp = 1456095600.0
        let date = Date(timeIntervalSince1970: timestamp)
        
        sut.titleTextField.text = "This is a title"
        sut.dateButton.setTitle(dateFormatter.string(from: date), for: .normal)
        sut.descriptionTextView.text = "A new begining"
        sut.priorityButton.setTitle("High", for: .normal)
        
        sut.taskManager = TaskManager()
        sut.save()
        
        let testTask = Task(title: "This is a title", description: "A new begining", timestamp: date.timeIntervalSince1970, priority: 1)
        let task = sut.taskManager?.task(at: 0)
        
        XCTAssertEqual(testTask, task)
    }
    
    func testIFSaveButtonSavesAction(){
        let saveButton = sut.saveTaskButton
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
}
