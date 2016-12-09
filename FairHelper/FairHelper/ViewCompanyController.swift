//
//  ViewCompanyController.swift
//  FairHelper
//
//  Created by Robert Chang on 12/6/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit

protocol ViewCompanyControllerDelegate {
    func controller(controller: ViewCompanyController)
}

class ViewCompanyController: UIViewController,ViewCompanyControllerDelegate {
    internal func controller(controller: ViewCompanyController) {
    }
    
    @IBOutlet var summary: UILabel!
    @IBOutlet var industry: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var contacts: UITextView!
    @IBOutlet var notes: UITextView!
    
    var company: Item = Item(name:"")
    var delegate: ViewCompanyControllerDelegate?
    var placeholderLabel : UILabel!
    var anotherLabel : UILabel!
    override func viewDidLoad() {
        let url = URL(string: company.image)
        title = company.name
        summary.textAlignment = NSTextAlignment.center;
        summary.numberOfLines = 0;
        summary.font = UIFont.systemFont(ofSize: 12.0);
        summary.text = company.summary
        contacts.text = company.contacts
        notes.text = company.notes
        industry.textAlignment = NSTextAlignment.center;
        industry.numberOfLines = 0;
        industry.font = UIFont.systemFont(ofSize: 12.0);
        industry.text = company.industry
        
        do{
            print(company.image)
            if company.image == ""{
                return
            }
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            imageView.image = UIImage(data: data!)
        }
        catch{
            
            print("invalid url")
            return
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Do you see me?")
        placeholderLabel.isHidden = true
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        company.contacts = contacts.text!
        company.notes = notes.text!
        print (company.notes)
        delegate?.controller(controller: self)
        // Dismiss View Controller
        dismiss(animated: true, completion: nil)
        
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
