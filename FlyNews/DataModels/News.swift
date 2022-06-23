//
//  News.swift
//  Tabbed app
//
//  Created by NHT Global on 22/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class News : Object{
    @objc dynamic var author :String?
    @objc dynamic var title :String?
    @objc dynamic var desc :String?
    @objc dynamic var url :String?
    @objc dynamic var urlToImage :String?
    @objc dynamic var publishedAt :String?
    @objc dynamic var content :String?
    @objc dynamic var source_name :String?
    @objc dynamic var custom_id : String?
    
    static func construct(json:JSON) -> News {
        
        let news = News()
        news.author = json["author"].stringValue
        news.title = json["title"].stringValue
        news.desc = json["description"].stringValue
        news.url = json["url"].stringValue
        news.urlToImage = json["urlToImage"].stringValue
        news.content = json["content"].stringValue
        news.publishedAt  = DateHelper.shared.DateConverter(json["publishedAt"].stringValue)
        news.source_name = json["source"]["name"].stringValue
        news.custom_id = json["publishedAt"].stringValue + json["source"]["id"].stringValue+json["source"]["name"].stringValue
        return news
    }
    
    override static func primaryKey() -> String?{
        return "custom_id"
    }
    
}
