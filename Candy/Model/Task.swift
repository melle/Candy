//
//  Task.swift
//  Candy
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

func ==(lhs: Task, rhs: Task) -> Bool {
    if lhs.timestamp != rhs.timestamp{
        return false
    }
    if lhs.description != rhs.description{
        return false
    }
    if lhs.title != rhs.title{
        return false
    }
    return true
}

import Foundation

struct Task: Equatable {
    
    let title: String
    let description: String
    let timestamp: Double
    let priority: Int
    var isChecked = false
    
    init(title: String, description: String, timestamp: Double, priority: Int) {
        self.title = title
        self.description = description
        self.timestamp = timestamp
        self.priority = priority
    }
    
    init() {
        title = ""
        description = ""
        timestamp = 0.0
        priority = 0
    }
}
