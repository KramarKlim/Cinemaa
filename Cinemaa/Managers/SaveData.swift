//
//  StorageManager.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import Foundation
import CoreData

class SaveData {
    
    static var shared = SaveData()
    
    var items: [Ticket] = []
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cinemaa")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<Ticket> = Ticket.fetchRequest()
        let viewContext = persistentContainer.viewContext
        do {
            items = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveItem(name: String, time: String, price: Int16, count: Int16) {
        let viewContext = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Ticket", in: viewContext) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? Ticket else { return }
        task.setValue(name, forKey: "name")
        task.setValue(time, forKey: "time")
        task.setValue(price, forKey: "price")
        task.setValue(count, forKey: "count")
        task.name = name
        task.time = time
        task.price = price
        task.count = count
        items.append(task)
        saveContext()
    }
    
    func deleteTask(for index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Ticket> = Ticket.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            context.delete(objects[index])
        }
        items.remove(at: index)
        saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
