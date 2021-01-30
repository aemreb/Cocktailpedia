//
//  DetailsViewController.swift
//  Cocktails
//
//  Created by Emre Boyacı on 24.01.2021.
//

import UIKit
import FirebaseDatabase

class DetailsViewController: UIViewController, IngredientsDelegate {

    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var ingredientsView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeLabel: UILabel!
    
    let u = Utility()
    
    var cocktailPhoto: UIImage?
    var ingredientsList: String = ""
    var cocktailName: String = ""
    var selectedCell: Int?
    var recipe: String = "loading..."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()

        if let cocktailPhoto = cocktailPhoto {
            cocktailImageView.image = cocktailPhoto
        }
        
        recipeLabel.text = recipe
        
        cocktailImageView.layer.cornerRadius = cocktailImageView.frame.height/2
        u.ingredientDelegate = self
        u.downloadCocktailIngredients(index: selectedCell ?? 0, reference: ref, completion: {(result) in
            self.didUpdateIngredients(ingredients_return: result)
        })
        titleLabel.text = cocktailName ?? "..."
        self.title = cocktailName ?? "..."
        
        ingredientsView.layer.shadowColor = UIColor.darkGray.cgColor
        ingredientsView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        ingredientsView.layer.shadowRadius = 8.0
        ingredientsView.layer.shadowOpacity = 0.7
        ingredientsView.layer.cornerRadius = 10.0
        ingredientsView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.30)
    }
    
    
    func splitIngredientsString(initial_string: String){
        ingredientsList = initial_string.replacingOccurrences(of: ",", with: "\n● ")
        ingredientsList = "●  " + ingredientsList
        ingredientsLabel.text = ingredientsList
    }
    

}

extension DetailsViewController{
    func didUpdateIngredients(ingredients_return: String) {
        splitIngredientsString(initial_string: ingredients_return)
        
    }
}
