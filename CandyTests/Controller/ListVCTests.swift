//
//  ListVCTests.swift
//  CandyTests
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import XCTest
@testable import Candy

class ListVCTests: XCTestCase {
    
    var sut: ListVC!
    
    override func setUp() {
        super.setUp()
        sut = ListVC()
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIfViewLoadsDataSource(){
        XCTAssertTrue(sut.taskTableView.dataSource is TaskListDataProvider)
    }
    
    func testIfViewLoadsDelegate(){
        XCTAssertTrue(sut.taskTableView.delegate is TaskListDataProvider)
    }
    
}
