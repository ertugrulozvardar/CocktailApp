//
//  DrinkDetailViewController.swift
//  CocktailApp
//
//  Created by obss on 24.05.2022.
//

import UIKit
import Kingfisher

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var ingredientOneLabel: UILabel!
    @IBOutlet weak var ingredientTwoLabel: UILabel!
    @IBOutlet weak var ingredientThreeLabel: UILabel!
    @IBOutlet weak var ingredientFourLabel: UILabel!
    @IBOutlet weak var ingredientFiveLabel: UILabel!
    @IBOutlet weak var ingredientSixLabel: UILabel!
    @IBOutlet weak var ingredientSevenLabel: UILabel!
    @IBOutlet weak var ingredientEightLabel: UILabel!
    @IBOutlet weak var ingredientNineLabel: UILabel!
    @IBOutlet weak var ingredientTenLabel: UILabel!
    @IBOutlet weak var ingredientElevenLabel: UILabel!
    @IBOutlet weak var ingredientTwelveLabel: UILabel!
    @IBOutlet weak var ingredientThirteenLabel: UILabel!
    @IBOutlet weak var ingredientFourteenLabel: UILabel!
    @IBOutlet weak var ingredientFifteenLabel: UILabel!
    
    var drinkId: String?
    private let drinkService: DrinkServiceProtocol = DrinkService()
    private var drinks: [Drink] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = drinkId {
            drinkService.getDrink(id: id) { result in
                switch result {
                case .success(let response):
                    self.drinks = response.drinks ?? []
                    self.updateUIElements(drinks: self.drinks)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let alertController = UIAlertController(title: "Hata!", message: "Karakter bulunamadı", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Tamam", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okButton)
            self.present(alertController, animated: true)
        }
    }
    
    
    func updateUIElements(drinks: [Drink]) {
        drinkImageView.kf.setImage(with: drinks.first?.strDrinkThumb)
        drinkNameLabel.text = drinks.first?.strDrink
        tipLabel.text = drinks.first?.strInstructions
        ingredientOneLabel.text = drinks.first?.strIngredient1
        ingredientTwoLabel.text = drinks.first?.strIngredient2
        ingredientThreeLabel.text = drinks.first?.strIngredient3
        ingredientFourLabel.text = drinks.first?.strIngredient4
        ingredientFiveLabel.text = drinks.first?.strIngredient5
        ingredientSixLabel.text = drinks.first?.strIngredient6
        ingredientSevenLabel.text = drinks.first?.strIngredient7
        ingredientEightLabel.text = drinks.first?.strIngredient8
        ingredientNineLabel.text = drinks.first?.strIngredient9
        ingredientTenLabel.text = drinks.first?.strIngredient10
        ingredientElevenLabel.text = drinks.first?.strIngredient11
        ingredientTwelveLabel.text = drinks.first?.strIngredient12
        ingredientThirteenLabel.text = drinks.first?.strIngredient13
        ingredientFourteenLabel.text = drinks.first?.strIngredient14
        ingredientFifteenLabel.text = drinks.first?.strIngredient15
    }

}
