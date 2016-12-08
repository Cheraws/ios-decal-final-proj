//
//  ListViewController.swift
//  FairHelper
//
//  Created by Robert Chang on 12/6/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController,AddCompanyViewControllerDelegate,ViewCompanyControllerDelegate
{
    var items = [Item]()
    
    let CellIdentifier = "Cell Identifier"
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        // Load Items
        loadItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Company List"
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(UIPushBehavior.addItem(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ListViewController.editItems(_:)))
        // Do any additional setup after loading the view.
    }
    func editItems(_ sender:UIBarButtonItem){
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddCompanyViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCompanyViewController" {
            if let navigationController = segue.destination as? UINavigationController,
                let addItemViewController = navigationController.viewControllers.first as? AddCompanyViewController {
                addItemViewController.delegate = self
            }
        }
        if segue.identifier == "ViewCompanyController" {
            if let navigationController = segue.destination as? UINavigationController,
                let viewCompanyController = navigationController.viewControllers.first as? ViewCompanyController {
                viewCompanyController.delegate = self
                viewCompanyController.company = sender as! Item
                
            }
        }
    }
    
    func controller(controller: AddCompanyViewController, name: String) {
        // Create Item
        let new_title = name.replacingOccurrences(of: " ", with: "_")
        let a = Scraper()
        
        let item = Item(name: new_title)
        a.scrapeWiki(name: name, item:item, controller: self)
        items.append(item)
        tableView.insertRows(at: [IndexPath(row: (items.count - 1), section: 0)], with: .none)
        
        saveItems()
        
   
    }
    func controller(controller: ViewCompanyController) {
        saveItems()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        // Fetch Item
        let item = items[(indexPath as NSIndexPath).row]
        
        // Configure Table View Cell
        cell.textLabel?.text = item.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    fileprivate func loadItems() {
        if let filePath = pathForItems() , FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item] {
                items = archivedItems
            }
        }
    }
    
    func saveItems() {
        if let filePath = pathForItems() {
            NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
        }
    }
    
    fileprivate func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = URL(string: documents) {
            return documentsURL.appendingPathComponent("items").path
        }
        
        return nil
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            saveItems()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        performSegue(withIdentifier: "ViewCompanyController", sender: item)
        //saveItems()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
