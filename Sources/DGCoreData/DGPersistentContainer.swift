//
//  DGPersistentContainer.swift
//  DGCoreData
//
//  Created by Xiao Jin on 2022/11/7.
//  Copyright © 2022 debugeek. All rights reserved.
//

import Foundation
import CoreData

open class DGPersistentContainer: NSPersistentContainer {

    public init(name: String, modelURL: URL, storeURL: URL) {
        super.init(name: name, managedObjectModel: NSManagedObjectModel(contentsOf: modelURL)!)

        persistentStoreDescriptions = [NSPersistentStoreDescription(url: storeURL)]

        loadPersistentStores(completionHandler: { _, _ in })
    }

    public func performSync(usingBlock block: ((NSManagedObjectContext) -> Void)) {
        let managedObjectContext: NSManagedObjectContext
        if Thread.isMainThread {
            managedObjectContext = viewContext
        } else {
            managedObjectContext = newBackgroundContext()
        }
        managedObjectContext.performAndWait {
            block(managedObjectContext)
        }
    }

    public func performAsync(usingBlock block: @escaping ((NSManagedObjectContext) -> Void)) {
        let managedObjectContext: NSManagedObjectContext
        if Thread.isMainThread {
            managedObjectContext = viewContext
        } else {
            managedObjectContext = newBackgroundContext()
        }
        managedObjectContext.perform {
            block(managedObjectContext)
        }
    }

}

