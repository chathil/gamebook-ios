//
//  LikedGameIdEntity.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/4/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import RealmSwift

class LikedGameIdEntity: Object {
    @objc dynamic var id: Int32 = -1
    override init() {
        
    }
    init(id: Int32) {
        self.id = id
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
