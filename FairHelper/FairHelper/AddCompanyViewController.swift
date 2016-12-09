//
//  AddItemViewController.swift
//  Career
//
//  Created by Robert Chang on 12/5/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

protocol AddCompanyViewControllerDelegate {
    func controller(controller: AddCompanyViewController, name: String)
}

class AddCompanyViewController: UIViewController, UITextFieldDelegate {


    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var searchController:UISearchController!
    @IBOutlet var searchBar:UISearchBar!
    var delegate: AddCompanyViewControllerDelegate?
    var placeholderLabel : UILabel!
    override func viewDidLoad() {
        title = "Add Company"
        definesPresentationContext = true
        nameTextField.delegate = self;
        placeholderLabel = UILabel()
        placeholderLabel.text = "Company name"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (nameTextField.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        nameTextField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (nameTextField.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.isHidden = !nameTextField.text!.isEmpty
        print (placeholderLabel.isHidden)
        print ("Now is it hidden?")
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldDidChange (_ textField: UITextField) {
        print("Do you see me?")
        placeholderLabel.isHidden = true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Do you see me?")
        placeholderLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let name = nameTextField.text {
            // Notify Delegate
            delegate?.controller(controller: self, name: name)
            
            // Dismiss View Controller
            dismiss(animated: true, completion: nil)
        }
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
