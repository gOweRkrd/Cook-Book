//
//  CookBookRecipes.swift
//  CookBook
//
//  Created by Александр Косяков on 29.11.2022.
//

import Foundation

// MARK: - CookBook

struct CookBookRecipes: Decodable {
    let cuisineRecipes: [CuisineRecipe]
    
    enum CodingKeys: String, CodingKey {
        case cuisineRecipes = "results"
    }
}


struct CuisineRecipe: Decodable {
    var id: Int
    var title: String
    var image: String?
}


