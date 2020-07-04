//
//  ProductsTableViewController.swift.swift
//  SlugNutrition
//
//  THIS APP IS BASED ON THE CODE PROVIDED BY BRIAN ADVENT
// https://www.youtube.com/watch?v=tdxKIPpPDAI
//
//  Created by Roberto Oregon on 07.03.20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var listOfProducts = [ProductDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfProducts.count) Products found"
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let product = listOfProducts[indexPath.row]
        
        cell.textLabel?.text = product.title
        cell.detailTextLabel?.text = product.id

        return cell
    }
}

extension ProductsTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let productRequest = ProductRequest(productSearch: searchBarText)
        productRequest.getProducts { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let products):
                self?.listOfProducts = products
            }
        }
    }
}
