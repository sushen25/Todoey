//
//  CategoryViewController.swift
//  Todoey
//
//  Created by sushen satturu on 20/7/18.
//  Copyright © 2018 Sushen Satturu. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    //MARK:- TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.title
        
        return cell
    }
    
    
    //MARK:- Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField : UITextField?
        
        let alert = UIAlertController(title: "Create New Category", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            
            let input = textField!.text!
            let newCategory = Category(context: self.context)
            newCategory.title = input
            
            self.categoryArray.append(newCategory)
            
            self.saveItems()
            
            
            
            
            
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category Name"
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
        
        
    }
    
    
    //MARK:- Data Manipulation Methods
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("error saving category, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("error fetching category data from context, \(error)")
        }
        
        tableView.reloadData()
        
        
    }
    


}
