//
//  Content.swift
//  FlyNews
//
//  Created by NHT Global on 27/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class ImageContent : Object{
    @objc dynamic var id :String?
    @objc dynamic var title :String?
    @objc dynamic var downsized_medium :String?
    @objc dynamic var bitly_gif_url :String?
    @objc dynamic var original : String?
    @objc dynamic var fixed_width_downsampled : String?
    @objc dynamic var preview_gif : String?
    @objc dynamic var clickRateUrl :String?
    
    static func construct(json:JSON) -> ImageContent {
        
        let content = ImageContent()
        content.id = json["id"].stringValue
        content.preview_gif = json["images"]["preview_gif"]["url"].stringValue
        content.fixed_width_downsampled = json["images"]["fixed_width_downsampled"]["url"].stringValue
        content.downsized_medium = json["images"]["downsized_medium"]["url"].stringValue
        content.original = json["images"]["original"]["url"].stringValue
        content.bitly_gif_url = json["bitly_gif_url"].stringValue
        content.clickRateUrl = json["analytics"]["onclick"]["url"].stringValue
        content.title = json["title"].stringValue
        return content
    }
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
}
