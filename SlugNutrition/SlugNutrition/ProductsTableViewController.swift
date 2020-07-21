//
//  ProductsTableViewController.swift.swift
//  SlugNutrition
//
//  THIS .SWIFT FILE IS BASED ON THE CODE PROVIDED BY BRIAN ADVENT
// https://www.youtube.com/watch?v=tdxKIPpPDAI
//
//  Created by Roberto Oregon on 07.03.20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//


import UIKit


//The GlobalSelectArr[0] contains the value of currently selected food item, it is cleared every time search for a new item
var GlobalSelectArr = [MealProducts?](repeating: nil, count: 1)
var GlobalCell = [UITableViewCell?](repeating: nil, count: 1)

 import UIKit

class ProductsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
   
    var SelectedFood: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
     var brandAFood: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
     var brandBFood: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
     var brandCFood: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
    
    
    var listOfProducts = [MealProducts]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfProducts.count) Products found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        searchBar.delegate = self
        
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfProducts.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //listOfProducts.sort{convertAPIValToInt (name: $0.fields.nf_calories) < convertAPIValToInt(name: $1.fields.nf_calories) }
        let product = listOfProducts[indexPath.row]
        
        // ## kcal oer 100g --> Equation is just x = weight_grams/100
        //let serv_per_hund_grams = convertAPIValToInt(name: product.fields.nf_serving_weight_grams) / 100
        //let cal_per_hund = convertAPIValToInt(name: product.fields.nf_calories) / 100
        
            cell.textLabel?.text = product.item_name//product.fields.item_name
            cell.detailTextLabel?.text = "\(product.nf_calories) kcal per serving) "
       
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        var DeSelectedItem = listOfProducts[indexPath.row]
        
        var cell = tableView.cellForRow(at: indexPath)
        
        if GlobalSelectArr[0] != nil {
            cell = GlobalCell[0]
            DeSelectedItem = GlobalSelectArr[0] ?? listOfProducts[indexPath.row]
        }
 
        
        cell?.accessoryType = .none
        
        //let cal_per_hund = convertAPIValToInt(name: DeSelectedItem.fields.nf_calories) / 100
        
        cell?.textLabel?.text = "\(DeSelectedItem.item_name)"
        cell?.textLabel?.numberOfLines = 1
        cell?.detailTextLabel?.text = "\(DeSelectedItem.nf_calories) kcal per serving) "
        cell?.sizeToFit()

        print("\(DeSelectedItem.item_name)")
        print("deselection worked")
        
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        //Did the user tap on a selected filter item? If so, do nothing
        let selectedItem = listOfProducts[indexPath.row]
        tableView.delegate?.tableView?(tableView, didDeselectRowAt: indexPath)

        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        cell?.textLabel?.text = " \(selectedItem.item_name) "
        UserDefaults.standard.set(cell?.textLabel?.text, forKey: "defaultFood") // saves text field text
        UserDefaults.standard.synchronize()
        let stuff = """
        Protein:        \(selectedItem.nf_protein)g
        Carbohydrates:  \(selectedItem.nf_total_carbohydrate)g
        Fats:           \(selectedItem.nf_total_fat)g
        """

        SelectedFood.item_name = String(selectedItem.item_name)
        SelectedFood.nf_calories = Double(selectedItem.nf_calories)
        SelectedFood.nf_protein = Double(selectedItem.nf_protein)
        SelectedFood.nf_total_carbohydrate = Double(selectedItem.nf_total_carbohydrate)
        SelectedFood.nf_total_fat = Double(selectedItem.nf_total_fat)
        
        cell?.detailTextLabel?.text = stuff
        
        cell?.textLabel?.numberOfLines = 10
        cell?.detailTextLabel?.numberOfLines = 5
        
        cell?.sizeToFit()
        
        
        GlobalSelectArr[0] = selectedItem
        GlobalCell[0] = cell
        print("Selection worked")
        
        UIView.animate(withDuration: 10.0, animations: {
            cell?.alpha = 1.0
        })
        
        resultsToSearchPage()
 

    }
    
    func convertValToDouble(name: String) -> Double {
        let value = "\(name)"
        var to_numeric = ""
        for letter in value.unicodeScalars{
            if 48...57 ~= letter.value{
                to_numeric.append(String(letter))
            }
        }
        let temp = Double (to_numeric) ?? 0
        print(temp)
        return temp
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.pin(to: view)
     }
    
    func resultsToSearchPage() {
        searchedFoodList.removeAll()
        
        if listOfProducts.count > 0 {
            brandAFood.item_name = String(listOfProducts[0].item_name)
            brandAFood.nf_calories = Double(listOfProducts[0].nf_calories)
            brandAFood.nf_protein = Double(listOfProducts[0].nf_protein)
            brandAFood.nf_total_carbohydrate = Double(listOfProducts[0].nf_total_carbohydrate)
            brandAFood.nf_total_fat = Double(listOfProducts[0].nf_total_fat)
            
            searchedFoodList.append(brandAFood)
        }
        
        if listOfProducts.count > 1 {
            brandBFood.item_name = String(listOfProducts[1].item_name)
            brandBFood.nf_calories = Double(listOfProducts[1].nf_calories)
            brandBFood.nf_protein = Double(listOfProducts[1].nf_protein)
            brandBFood.nf_total_carbohydrate = Double(listOfProducts[1].nf_total_carbohydrate)
            brandBFood.nf_total_fat = Double(listOfProducts[1].nf_total_fat)
            
            searchedFoodList.append(brandBFood)
        }
        if listOfProducts.count > 2 {
            brandCFood.item_name = String(listOfProducts[2].item_name)
            brandCFood.nf_calories = Double(listOfProducts[2].nf_calories)
            brandCFood.nf_protein = Double(listOfProducts[2].nf_protein)
            brandCFood.nf_total_carbohydrate = Double(listOfProducts[2].nf_total_carbohydrate)
            brandCFood.nf_total_fat = Double(listOfProducts[2].nf_total_fat)
            
            searchedFoodList.append(brandCFood)
        }
        searchedFoodList.append(SelectedFood)
        
    }
    
    /*

    func convertAPIValToInt(name: FormFieldValueType) -> Int {
        let value = "\(name)"
        var to_numeric = ""
        for letter in value.unicodeScalars{
            if 48...57 ~= letter.value{
                to_numeric.append(String(letter))
            }
        }
        let temp = Int(to_numeric) ?? 0
        return temp
    }*/
}

extension ProductsTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /*
        GlobalCell[0]?.accessoryType = .none
        GlobalCell[0] = nil
        GlobalSelectArr[0] = nil
 */
        guard let searchBarText = searchBar.text else {return}
        print(searchBarText)
        let productRequest = ProductRequest(productSearch: searchBarText)
        var productAdded: MealProducts = MealProducts(item_name: "", brand_name: "generic", nf_calories: 0.0, nf_total_fat: 0.0, nf_total_carbohydrate: 0.0, nf_protein: 0.0)
        
        for rows in productRows{
            var array = rows.components(separatedBy: ",")
            
            array[2] = array[2].replacingOccurrences(of: "g", with: " ")
            array[3] = array[3].replacingOccurrences(of: "g", with: " ")
            array[4] = array[4].replacingOccurrences(of: "g", with: " ")
            
            productAdded.item_name = array[0]
            productAdded.nf_calories = convertValToDouble(name: array[1])
            productAdded.nf_total_fat = convertValToDouble(name: array[2])
            productAdded.nf_total_carbohydrate = convertValToDouble(name: array[3])
            productAdded.nf_protein = convertValToDouble(name: array[4])
            
            listOfProducts.append(productAdded)
        
        }
        //listOfProducts = csvRows
        
    }
}

