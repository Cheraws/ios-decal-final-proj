//
//  SearchCompanyViewController.swift
//  FairHelper
//
//  Created by Robert Chang on 12/8/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit


extension String {
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
}
protocol SearchCompanyViewControllerDelegate {
    func controller(controller: SearchCompanyViewController, name: String)
}


class SearchCompanyViewController: UITableViewController, UISearchResultsUpdating {

    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if searchText.characters.count == 0{
            items = originalItems
            tableView.reloadData()
            return
        }
        let a = Item(name: searchText)
        var original = [Item]()
        original.append(a)
        let filteredItems = originalItems.filter { candy in
            return candy.name.lowercased().contains(searchText.lowercased())
        }
        items = original + filteredItems
        tableView.reloadData()
        print ("is anything happening?")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var items = [Item]()
    var originalItems = [Item]()
    let CellIdentifier = "Cell Identifier"
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        // Load Items
        //loadItems()
    }
    
    @IBOutlet var searchController: UISearchController!
    
    var delegate: SearchCompanyViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Company List"
        
        let path = Bundle.main.url(forResource: "company_list", withExtension: "txt")
        //loading list of Companies
        do{
            let text2 = try String(contentsOf: path!, encoding: String.Encoding.utf8)
            print (text2)
            
            let values = text2.components(separatedBy: "\n")
            for name in values{
                if(name == ""){
                    continue
                }
                let item = Item(name: name)
                items.append(item)
                tableView.insertRows(at: [IndexPath(row: (items.count - 1), section: 0)], with: .none)

            }
            originalItems = items
        }
        catch{
            print("error")
        }
        print("Am I in the new controller?")
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        // Do any additional setup after loading the view.
    }
    func editItems(_ sender:UIBarButtonItem){
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    
    func addItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddCompanyViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        let item = items[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    fileprivate func loadItems() {
        if let filePath = pathForItems() , FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item] {
                items = archivedItems
                print (filePath)
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
            return documentsURL.appendingPathComponent("items2").path
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            //saveItems()
        }
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        
        delegate?.controller(controller: self, name: item.name)
        self.performSegue(withIdentifier: "unwindToList", sender: self)
        print(self)
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
