//
//  DetailRecipe.swift
//  CookBook
//
//  Created by Дария Григорьева on 30.11.2022.
//

import Foundation

struct DetailRecipe: Decodable {
    let title: String
    let image: String
    let readyInMinutes: Int
    let extendedIngredients: [Ingredient]
    let summary: String
}

struct Ingredient: Decodable {
    let name: String
    let amount: Double
    let unit: String?
}

