//
//  ViewController.swift
//  Todoey
//
//  Created by Joseph on 31/5/18.
//  Copyright © 2018 Joseph. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "BUy Eggs", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    let arrayKeyName:String = "TodoListArray"
    
    @IBOutlet var todoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: arrayKeyName) as? [String] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        if cell?.accessoryType == UITableViewCellAccessoryType.checkmark { // add Check Mark to the Cell
            cell?.accessoryType = .none
        }else{
            cell?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true) // fade out of the grey color of cell as soon as tab the cell.
    }
    
    
    //MARK = Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "wassup", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add item button on our UIAlert
            print(textField.text!)
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: self.arrayKeyName)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todo Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

