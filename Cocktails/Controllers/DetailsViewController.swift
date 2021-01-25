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
    @IBOutlet weak var titleLabel: UILabel!
    let u = Utility()
    var ingredientsList: String = ""
    var cocktailName: String = ""
    var selectedCell: Int?
    
    
    override func viewDidLoad() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        super.viewDidLoad()
        cocktailImageView.layer.cornerRadius = cocktailImageView.frame.height/2
        u.ingredientDelegate = self
        u.downloadCocktailIngredients(index: selectedCell ?? 0, reference: ref, completion: {(result) in
            self.didUpdateIngredients(ingredients_return: result)
        })
        titleLabel.text = cocktailName ?? "..."
        self.title = cocktailName ?? "..."
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
