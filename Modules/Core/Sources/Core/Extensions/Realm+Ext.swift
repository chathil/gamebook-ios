//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/29/20.
//

import RealmSwift
import Cleanse

public extension Realm {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.bind(Realm.self).to { () -> Realm in
                if let realm = try? Realm() {
                    return realm
                } else {
                    fatalError(DatabaseError.invalidInstance.localizedDescription)
                }
            }
        }
    }
}
