//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
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
