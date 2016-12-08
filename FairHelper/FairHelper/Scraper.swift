//
//  Scraper.swift
//  FairHelper
//
//  Created by Robert Chang on 12/6/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import Foundation
import Alamofire
import Kanna
extension String {
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map { result.rangeAt($0).location != NSNotFound
                ? nsString.substring(with: result.rangeAt($0))
                : ""
            }
        }
    }
}

class Scraper{
    public var scraping = false
    public var values = ("","")
    func scrapeWiki(name: String,item: Item, controller:ListViewController) -> Void{
        self.values = (name, "")
        let link = "https://en.wikipedia.org/wiki/" + name
            Alamofire.request(link).responseString { response in
            print("\(response.result.isSuccess)")
                if let html = response.result.value {
                    self.parseHTML(html: html, item: item)
                    print("Summary received")
                    controller.saveItems()
                    
                }
            }
        //Wait until scraping is done.
    }

    func parseHTML(html: String, item: Item) -> Void {
    
    if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
        var title = doc.title!
        title = title.replacingOccurrences(of: "- Wikipedia", with: "")
        print(title)
        for show in doc.css("p") {
            let text = show.text!
            if text.hasPrefix("Coordinates"){
            }
            else{
                item.summary = show.text!
                break
            }
        }
        for tr in doc.css("tr"){
            let countSite = (tr.toHTML!.matchingStrings(regex: "src=\"//upload.*svg.png\""))
            if countSite.count >= 1{
                let subsized = countSite[0][0]
                let sized = subsized.matchingStrings(regex: "upload.*svg.png")
                item.image = "http://" + sized[0][0]
                print(sized[0][0])
                break
            }
            
        }
        for tr in doc.css("tr"){
            do{
                let part_html = tr.toHTML!
                let regex = try NSRegularExpression(pattern: ".*Industry</th>", options: [])
                let results = regex.numberOfMatches(in: part_html, options: [], range:NSMakeRange(0, part_html.characters.count))
                if results > 0{
                    let values = tr.text!.components(separatedBy: "\n")
                    var industries = ""
                    for i in values{
                        if (i != "Industry" && i != ""){
                            industries += i + " "
                            
                        }
                        
                    }
                    item.industry = industries
                    return
                }

            }catch let _ as NSError{
                print("invalid")
                return
            }
            

        }
        return
        print("over already?")
        
    }
}
}
