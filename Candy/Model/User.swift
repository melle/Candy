//
//  User.swift
//  Candy
//
//  Created by SimpuMind on 12/1/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object{
    @objc dynamic var username = ""
    @objc dynamic var password = ""
}
