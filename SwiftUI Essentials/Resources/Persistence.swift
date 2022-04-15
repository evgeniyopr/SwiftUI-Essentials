//
//  PersistenceController.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 14.04.2022.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Stash")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: ((Error?) -> Void)?) {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                completion?(nil)
            } catch {
                completion?(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: ((Error?) -> Void)?) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
}
