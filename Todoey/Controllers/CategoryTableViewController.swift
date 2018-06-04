//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Joseph on 2/6/18.
//  Copyright © 2018 Joseph. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories:Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category added"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    //MARK: - Data Manipulation Methods
    func saveCategory(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error! \(error)")
        }
        tableView.reloadData()
    }

    func loadCategory() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: Any) {
        var uiTextField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Save", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = uiTextField.text!

            self.saveCategory(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            uiTextField.placeholder = "Insert Category Name."
            uiTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

}
