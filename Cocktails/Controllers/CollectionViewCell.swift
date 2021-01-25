//
//  CollectionViewCell.swift
//  Cocktails
//
//  Created by Emre Boyacı on 19.01.2021.
//

import UIKit
import Kingfisher
import FirebaseStorage

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cocktailCellImageView: UIImageView!
    @IBOutlet weak var cocktailTitle: UILabel!
    @IBOutlet weak var cocktailDuration: UILabel!
    let u = Utility()
    
    func configure(with cocktailTitleString: String) {
        if let cocktailTitle = cocktailTitle {
            cocktailTitle.text = cocktailTitleString
            cocktailCellImageView.image = #imageLiteral(resourceName: "default_cocktail")
            cocktailDuration.text = "10 mins"
        }
        
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        containerView.layer.shadowRadius = 8.0
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.cornerRadius = 10.0

        
        cocktailCellImageView.layer.cornerRadius = 10.0
        cocktailCellImageView.clipsToBounds = true
    }
    
      

}
