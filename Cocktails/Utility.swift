//
//  Utility.swift
//  Cocktails
//
//  Created by Emre Boyacı on 22.01.2021.
//

import Foundation
import FirebaseDatabase
import Alamofire
import FirebaseStorage

protocol CocktailsDelegate: class {
    func didUpdateCocktails(cocktails_return: [Cocktail])
}

protocol IngredientsDelegate: class {
    func didUpdateIngredients(ingredients_return: String)
}


class Utility{
    
    
    
    private var cocktailsArray: [Cocktail] = []
    private var randIndexes: [Int] = []
    weak var delegate: CocktailsDelegate?
    weak var ingredientDelegate: IngredientsDelegate?
    let imageSearchAPIKey = "AIzaSyB3hoWymFLYZNiUtlxtJq6XREBmOsghQ5Y"
    let customSearchEngineID = "985045b7e4c4b2405"    
    func returnCocktailNames(){
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        // var cocktailsArray: [String] = []
        
        
        for _ in 0...20{
            let rand = Int.random(in: 0...686)
            randIndexes.append(rand)
            downloadData(index: rand, reference: ref, completion: { (cocktail) in
                self.cocktailsArray.append(cocktail)
                self.delegate?.didUpdateCocktails(cocktails_return: self.cocktailsArray)
            })
        }
    }
    
    func getRandomArray() -> [Int]{
        return randIndexes
    }
    
    
    func downloadData(index: Int, reference: DatabaseReference, completion: @escaping (Cocktail) -> ()){
        
        reference.child("\(index)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                var cocktail = Cocktail(bartender: value?["Bartender"] as? String ?? "",
                                        cocktailName: value?["Cocktail Name"] as? String ?? "",
                                        garnish: value?["Garnish"] as? String ?? "",
                                        glassware: value?["Glassware"] as? String ?? "",
                                        ingredients: value?["Ingredients"] as? String ?? "",
                                        location: value?["Location"] as? String ?? "",
                                        notes: value?["Notes"] as? String ?? "",
                                        preparation: value?["Preparation"] as? String ?? ""
                                    )
                
                print(cocktail)
                
                
                
                
                
            completion: do {
                completion(cocktail)
            }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
        
       
    }
    
    func downloadCocktailIngredients(index: Int, reference: DatabaseReference, completion: @escaping (String) -> ()){
        var returnValue: String = ""
        reference.child("\(index)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            returnValue = value?["Ingredients"] as? String ?? ""
            print(returnValue)
            
            completion: do {
                completion(returnValue)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getCocktailImages(completion: @escaping (UIImage) -> ()){
        
        var image: UIImage?
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        let random = 752 + Int.random(in: 0...400)
        let picRef = storageRef.child("\(random).jpg")
        
        picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            
            if error != nil {
            } else {
                image = UIImage(data: data!)
            }
        }
        
        completion: do {
            if let image = image{
                completion(image)
                
            }
        }
        
        
    }
    
}



