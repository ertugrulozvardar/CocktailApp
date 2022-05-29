//
//  CategoryViewController.swift
//  CocktailApp
//
//  Created by obss on 24.05.2022.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    @IBOutlet weak var categoryAlcoholic: UIButton!
    @IBOutlet weak var categoryNonAlcoholic: UIButton!
    @IBOutlet weak var categoryOrdinaryDrink: UIButton!
    @IBOutlet weak var categoryCocktail: UIButton!
    private let customColors = CustomColors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        if let drinkListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DrinkListViewController.self)) as? DrinkListViewController {
            switch sender.titleLabel?.text! {
            case categoryAlcoholic.titleLabel?.text!:
                drinkListVC.viewBackgroundColor = customColors.greenTeal
            case categoryNonAlcoholic.titleLabel?.text!:
                drinkListVC.viewBackgroundColor = customColors.narenjiOrange
            case categoryOrdinaryDrink.titleLabel?.text!:
                drinkListVC.viewBackgroundColor = customColors.jadeDust
            case categoryCocktail.titleLabel?.text!:
                drinkListVC.viewBackgroundColor = customColors.highlighterPink
            default:
                drinkListVC.viewBackgroundColor = customColors.goodNight
            }
            drinkListVC.categoryName = sender.titleLabel?.text!
            self.navigationController?.pushViewController(drinkListVC, animated: true)
        }
    }
}
