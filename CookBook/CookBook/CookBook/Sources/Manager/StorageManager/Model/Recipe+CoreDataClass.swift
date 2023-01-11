//
//  Recipe+CoreDataClass.swift
//  CookBook
//
//  Created by Дария Григорьева on 10.12.2022.
//
//

import CoreData
import Foundation

@objc(Recipe)
public class Recipe: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var image: String?
}
