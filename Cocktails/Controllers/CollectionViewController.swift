//
//  CollectionViewController.swift
//  Cocktails
//
//  Created by Emre Boyacı on 19.01.2021.
//

import UIKit
import FirebaseStorage


private let reuseIdentifier = "Cell"

var cocktailIndexes: [Int] = []
var cocktails: [String] = []
var cocktailObjects: [Cocktail] = []
var images: [UIImage] = [] 

class CollectionViewController: UICollectionViewController, CocktailsDelegate {
    @IBOutlet var mainCollectionView: UICollectionView!
    let u = Utility()

   
    override func viewDidLoad() {
        super.viewDidLoad()
            
        u.delegate = self
        for _ in 0...20{
            u.getCocktailImages(done: {(image, cocktail) in
                images.append(image)
                cocktailObjects.append(cocktail)
                self.collectionView.reloadData()
            })
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
   
        var cell = CollectionViewCell()
        
        if let cocktailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
        
            cocktailCell.cocktailCellImageView.image = images[indexPath.row]
            cocktailCell.cocktailTitle.text = cocktailObjects[indexPath.row].cocktailName
            cocktailCell.cocktailDuration.text = "10 mins"
            cocktailCell.configure()
            cell = cocktailCell
            
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "detailSegue"{
            let selectedIndexPath = sender as! NSIndexPath
            let selectedCocktail = cocktailObjects[selectedIndexPath.row]
            let vc = segue.destination as! DetailsViewController
            
            
            vc.selectedCell = u.getRandomArray()[selectedIndexPath.row]
            vc.cocktailName = selectedCocktail.cocktailName
            vc.cocktailPhoto = images[selectedIndexPath.row]
        }
    }
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//            if indexPath.row%18 == 0 {
//                u.returnCocktailNames()
//            }
//    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CollectionViewController{
   
    func didUpdateCocktails(cocktails_return: [Cocktail]) {
        let names = cocktails_return.map({ (cocktail: Cocktail) -> String in
            cocktail.cocktailName
        })
        
//        let imageArray = cocktails_return.map({ (cocktail: Cocktail) -> UIImage in
//            UIImage(data: cocktail.image)!
//        })
        cocktails = names
//        images = imageArray
        
        collectionView?.reloadData()
    }
}
