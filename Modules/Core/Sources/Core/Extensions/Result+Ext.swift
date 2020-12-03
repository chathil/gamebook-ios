//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/28/20.
//

import RealmSwift

public extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
