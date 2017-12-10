//
//  TaskTests.swift
//  CandyTests
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import XCTest
@testable import Candy

class TaskTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTaskWithAllParams(){
        let task = Task(title: "Foo", description: "Bar", timestamp: 0.0, priority: 1)
        XCTAssertEqual(task.title, "Foo")
        XCTAssertEqual(task.description, "Bar")
        XCTAssertEqual(task.timestamp, 0.0)
    }
}
