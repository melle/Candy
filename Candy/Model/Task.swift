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
import RealmSwift

class Task: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var taskDescription: String = ""
    @objc dynamic var timestamp: Date = Date(timeIntervalSince1970: 1)
    @objc dynamic var priority: Int = 0
    @objc dynamic var isChecked: Bool = false
}
