//
//  Item.swift
//  FairHelper
//
//  Created by Robert Chang on 12/6/16.
//  Copyright © 2016 Robert. All rights reserved.
//

import Foundation


class Item: NSObject, NSCoding {
    
    var uuid: String = UUID().uuidString
    var name: String = ""
    var image: String = ""
    var summary:String = ""
    var industry:String = ""
    var notes: String = ""
    var contacts: String = ""
    
    // MARK: -
    // MARK: Initialization
    init(name: String) {
        super.init()
        
        self.name = name
    }

    
    // MARK: -
    // MARK: NSCoding Protocol
    required init?(coder decoder: NSCoder) {
        super.init()
        
        if let archivedUuid = decoder.decodeObject(forKey: "uuid") as? String {
            uuid = archivedUuid
        }
        
        if let archivedSummary = decoder.decodeObject(forKey: "summary") as? String {
            summary = archivedSummary
        }
        
        if let archivedName = decoder.decodeObject(forKey: "name") as? String {
            name = archivedName
        }
        if let archivedImage = decoder.decodeObject(forKey: "image") as? String {
            image = archivedImage
        }
        if let archivedIndustry = decoder.decodeObject(forKey: "industry") as? String {
            industry = archivedIndustry
        }
        if let archivedNotes = decoder.decodeObject(forKey: "notes") as? String {
            notes = archivedNotes
        }
        if let archivedContacts = decoder.decodeObject(forKey: "contacts") as? String {
            contacts = archivedContacts
        }    }
    
    func encode(with coder: NSCoder) {
        coder.encode(uuid, forKey: "uuid")
        coder.encode(name, forKey: "name")
        coder.encode(notes, forKey: "notes")
        coder.encode(summary, forKey: "summary")
        coder.encode(contacts, forKey: "contacts")
        coder.encode(industry, forKey: "industry")
        coder.encode(image, forKey: "image")
    }
    
}
