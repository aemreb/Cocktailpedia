//
//  Cocktail.swift
//  Cocktails
//
//  Created by Emre Boyacı on 24.01.2021.
//

import Foundation
import UIKit


class Cocktail: Codable{
    
    let bartender, cocktailName, garnish, glassware: String
    let ingredients, location, notes, preparation: String
    
    enum CodingKeys: String, CodingKey {
        case bartender = "Bartender"
        case cocktailName = "Cocktail Name"
        case garnish = "Garnish"
        case glassware = "Glassware"
        case ingredients = "Ingredients"
        case location = "Location"
        case notes = "Notes"
        case preparation = "Preparation"
    }
    
    
    init(bartender: String, cocktailName: String, garnish: String, glassware: String, ingredients: String, location: String, notes: String, preparation: String) {
        self.bartender = bartender
        self.cocktailName = cocktailName
        self.garnish = garnish
        self.glassware = glassware
        self.ingredients = ingredients
        self.location = location
        self.notes = notes
        self.preparation = preparation
    }
    
}
