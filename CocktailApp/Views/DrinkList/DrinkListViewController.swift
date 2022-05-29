//
//  DrinkListViewController.swift
//  CocktailApp
//
//  Created by obss on 24.05.2022.
//

import UIKit

class DrinkListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: String(describing: DrinkTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DrinkTableViewCell.self))
        }
    }

    private let customColors = CustomColors()
    public var categoryName: String?
    public var viewBackgroundColor: UIColor?
    private let drinkService: DrinkServiceProtocol = DrinkService()
    private var drinks: [Drink] = []
    private var filteredDrinks = [Drink]()
    private var isFilterActive = false


    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
        initData()
        
    }
    
    func initSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        self.tableView.tableHeaderView = searchBar
    }
    
    func initData() {
        if let category = categoryName {
            drinkService.getAllDrinks(category: category) { result in
                switch result {
                case .success(let response):
                    self.drinks = response.drinks ?? []
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: -TableView Delegate & DataSource Methods
extension DrinkListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterActive {
            return filteredDrinks.count
        } else {
            return drinks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DrinkTableViewCell.self), for: indexPath) as! DrinkTableViewCell
        let drink: Drink
        
        if isFilterActive {
            drink = filteredDrinks[indexPath.row]
        } else {
            drink = drinks[indexPath.row]
        }
        
        cell.updateBackgroundColor(bckgroundColor: viewBackgroundColor ?? customColors.goodNight)
        cell.updateViewBackgroundColor(bckgroundColor: viewBackgroundColor ?? customColors.goodNight)
        cell.configure(drink: drink)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let drinkDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DrinkDetailViewController.self)) as? DrinkDetailViewController {
            
            if isFilterActive {
                drinkDetailsVC.drinkId = filteredDrinks[indexPath.row].idDrink
            } else {
                drinkDetailsVC.drinkId = drinks[indexPath.row].idDrink
            }
            self.navigationController?.pushViewController(drinkDetailsVC, animated: true)
        }
    }
}
//MARK: -SearchBar Delegate Methods
extension DrinkListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            initData()
        }
        else {
            filteredDrinks = drinks.filter({ drink in
                return drink.strDrink?.range(of: searchText, options: [ .caseInsensitive ]) != nil
            })
        }
        isFilterActive = true
        self.tableView.reloadData()
    }
}
