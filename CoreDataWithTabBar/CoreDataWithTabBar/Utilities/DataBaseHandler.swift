//
//  DataBaseHandler.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 18/02/23.
//

import UIKit
import CoreData


final class DataBaseHandler {
    static let shared = DataBaseHandler()
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext : NSManagedObjectContext!
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //MARK: fetches data
    func fetchData() -> [FavGifs] {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "FavGifs")
        var favGifs = [FavGifs]()
        //3
        do {
            favGifs = try (managedContext.fetch(fetchRequest) as! [FavGifs])
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return favGifs
    }
    
    //MARK: deletes data
    func deleteData() -> [FavGifs] {
        //2
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "FavGifs")
        let result = try? managedContext.fetch(fetchRequest)
        let resultData = result as! [FavGifs]

        // 3
        
        for i in resultData{
            managedContext.delete(i)
            
            // 4
            do {
                try managedContext.save()
                // people.append(person)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        return fetchData()
    }
    
    //MARK: saves data
    func saveData(data: [[String:Any]]) {
        // 2
        let entity =
        NSEntityDescription.entity(forEntityName: "FavGifs",
                                   in: managedContext)!
        
        
        
        // 3
       for i in data {
            let person = NSManagedObject(entity: entity, insertInto: managedContext)
            person.setValuesForKeys(i)
            
            // 4
            do {
                try managedContext.save()
                // people.append(person)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    //MARK: searches data
    func searchData(imageId:String) -> FavGifs? {
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "FavGifs")

        fetchRequest.predicate = NSPredicate(
            format: "imageId = %@", imageId
        )

        // Get a reference to a NSManagedObjectContext
        let context = managedContext

        // Perform the fetch request to get the objects
        // matching the predicate
        if let data =  try? context?.fetch(fetchRequest).first as? FavGifs {
            return data
        }
        return nil
        
    }
}
