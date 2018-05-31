//
//  ViewController.swift
//  Todoey
//
//  Created by Joseph on 31/5/18.
//  Copyright © 2018 Joseph. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    let arrayKeyName:String = "TodoListArray"
    
    @IBOutlet var todoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike1"
        itemArray.append(newItem)

        let newItem1 = Item()
        newItem1.title = "Find Mike2"
        itemArray.append(newItem1)

        let newItem2 = Item()
        newItem2.title = "Find Mike3"
        itemArray.append(newItem2)

        if let items = defaults.array(forKey: arrayKeyName) as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
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
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true) // fade out of the grey color of cell as soon as tab the cell.
        tableView.reloadData()
    }
    
    
    //MARK = Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "wassup", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add item button on our UIAlert

            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
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

