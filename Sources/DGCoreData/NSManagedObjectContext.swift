//
//  NSManagedObjectContext.swift
//  DGCoreData
//
//  Created by Xiao Jin on 2022/11/7.
//  Copyright © 2022 debugeek. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {

    @discardableResult
    public func new<T: NSManagedObject>() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: T.description() , into: self) as! T
    }

    public func count<T: NSManagedObject>(entity: T.Type, condition: Any? = nil) -> Int {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.description())
        fetchRequest.includesSubentities = false
        if let condition = condition, let predicate = NSPredicate.from(condition) {
            fetchRequest.predicate = predicate
        }
        guard let count = try? count(for: fetchRequest) else { return 0 }
        return count
    }

    @discardableResult
    public func delete<T: NSManagedObject>(entity: T.Type, condition: Any? = nil) -> Bool {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.description())
        if let condition = condition, let predicate = NSPredicate.from(condition) {
            fetchRequest.predicate = predicate
        }
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        guard let _ = try? execute(deleteRequest) else { return false }
        return true
    }

    public func select<T: NSManagedObject>(condition: Any? = nil, order: Any? = nil, limit: Int? = nil) -> [T] {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.description())
        if let condition = condition, let predicate = NSPredicate.from(condition) {
            fetchRequest.predicate = predicate
        }
        if let order = order, let sortDescriptors = NSSortDescriptor.from(order) {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }

        guard let results = try? fetch(fetchRequest) else { return [] }
        return results
    }

}

extension NSManagedObjectContext {

    @discardableResult
    public func saveIfNeeded() -> Bool {
        guard parent != nil ||
                persistentStoreCoordinator?.persistentStores.isEmpty == false else { return false }

        guard !insertedObjects.isEmpty ||
                !deletedObjects.isEmpty ||
                updatedObjects.contains(where: { $0.hasPersistentChangedValues }) else { return false }

        try? save()

        return true
    }

}
