//
//  DrinkTableViewCell.swift
//  CocktailApp
//
//  Created by obss on 24.05.2022.
//

import UIKit
import Kingfisher

class DrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var drinkImageView: UIImageView! {
        didSet{
            drinkImageView.layer.cornerRadius = 30
        }
    }
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    func configure(drink: Drink){
        drinkNameLabel.text = drink.strDrink
        drinkImageView.kf.setImage(with: drink.strDrinkThumb)
    }
    
    func updateBackgroundColor(bckgroundColor: UIColor) {
        cellView.backgroundColor = bckgroundColor
    }
    
    func updateViewBackgroundColor(bckgroundColor: UIColor) {
        backgroundColor = bckgroundColor
    }
}
