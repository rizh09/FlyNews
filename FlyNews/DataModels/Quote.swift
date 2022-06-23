//
//  Quote.swift
//  FlyNews
//
//  Created by NHT Global on 4/6/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Quote : Object{
    
    @objc dynamic var title :String?
    @objc dynamic var date :String?
    @objc dynamic var urlImage :String?
    
    static func construct(title:String,date:String,urlImage:String) -> Quote {
        let quote = Quote()
        quote.title = title
        quote.date = date
        quote.urlImage = urlImage
        return quote
    }
    
    override static func primaryKey() -> String?{
        return "title"
    }
    
}
