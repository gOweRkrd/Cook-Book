//
//  StorageManager.swift
//  CookBook
//
//  Created by Дария Григорьева on 10.12.2022.
//
import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipeCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchItems() -> [Recipe] {
        let fetchRequest = Recipe.fetchRequest()
        do {
            let recipes = try viewContext.fetch(fetchRequest)
            return recipes
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchIds() -> Set<Int> {
        Set(fetchItems().compactMap { Int($0.id) })
    }
    
    func createItem(from cuisineRecipe: CuisineRecipe) -> Recipe {
        let recipe = Recipe(context: viewContext)
        recipe.id = String(cuisineRecipe.id)
        recipe.title = cuisineRecipe.title
        recipe.image = cuisineRecipe.image
        return recipe
    }
    
    func saveRecipe(_ recipe: Recipe) {
        viewContext.insert(recipe)
        saveContext()
    }
    
    func delete(_ id: Int) {
        guard let recipe = fetchItems().first(where: { $0.id == String(id) }) else {
            return
        }
        
        viewContext.delete(recipe)
        saveContext()
    }
    
    func delete(_ recipe: Recipe) {
        viewContext.delete(recipe)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    private func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
