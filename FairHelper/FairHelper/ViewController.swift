//
//  ViewController.swift
//  FairHelper
//
//  Created by Robert Chang on 12/5/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {
    
    
    @IBOutlet var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Company"
        nameTextField.text = "Company Name"
        nameTextField.textColor = UIColor.lightGray
        self.scrapeNYCMetalScene()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    func scrapeNYCMetalScene() -> Void {
        Alamofire.request("https://en.wikipedia.org/wiki/Arista_Networks").responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) -> Void {
        
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
             var title = doc.title!
             title = title.replacingOccurrences(of: "- Wikipedia", with: "")
             print(title)
            
            for show in doc.css("p") {
                
                print (show.text!)
                print ("gap")
                return
            }
            for img in doc.css("img"){
                print(img["href"])
                print("img?")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

