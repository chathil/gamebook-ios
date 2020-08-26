//
//  GameEntity+Extension.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/11/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import CoreData

extension GameEntity: Identifiable {
    
    var genresString: [String] {
        get {
            return genres as? Array<String> ?? []
        }
        set {
            genres = newValue as NSArray
        }
    }
    
    var publishersString: [String] {
        get {
            return publishers as? Array<String> ?? []
        }
        set {
            publishers = newValue as NSArray
        }
    }
    
    public var backgroundUrl: URL? {
        return URL(string: backgroundImage ?? "https://api.rawg.io/api/games")
    }
    
    var genre: String {
        return genresString.first ?? "No Genre"
    }
    
    static func isLiked(context: NSManagedObjectContext, completion: @escaping([Int32]) -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: GameEntity.entity().name ?? "Game")
        context.perform {
            do {
                let results = try context.fetch(fetchRequest)
                let ids = results.map {
                    $0.value(forKeyPath: "id") as! Int32
                }
                completion(ids)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    static func delete(context: NSManagedObjectContext, id: Int32, completion: @escaping() -> () ) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GameEntity.entity().name ?? "Game")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        context.perform {
            do {
                if let batchDeleteResult = try? context.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                    batchDeleteResult.result != nil {
                    try context.saveContext()
                    completion()
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
}
