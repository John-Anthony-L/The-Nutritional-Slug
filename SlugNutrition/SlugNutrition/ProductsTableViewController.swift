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
        Protien:        \(selectedItem.nf_protein)g
        Carbohydrates:  \(selectedItem.nf_total_carbohydrate)g
        Fats:           \(selectedItem.nf_total_fat)g
        """

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
        
 

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.pin(to: view)
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
            productAdded.nf_calories = Double(array[1].trimmingCharacters(in: .whitespaces)) as! Double
            productAdded.nf_total_fat = Double(array[2].trimmingCharacters(in: .whitespaces)) as! Double
            productAdded.nf_total_carbohydrate = Double(array[3].trimmingCharacters(in: .whitespaces)) as! Double
            productAdded.nf_protein = Double(array[4].trimmingCharacters(in: .whitespaces)) as! Double
            
            listOfProducts.append(productAdded)
        
        }
        //listOfProducts = csvRows
        
    }
}

