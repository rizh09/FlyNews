//
//  RealmManager.swift
//  Tabbed app
//
//  Created by NHT Global on 23/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager:NSObject{
    
    static let shared = RealmManager()
    let realm = try! Realm()
    func getAllNews()-> Results<News>{
        return realm.objects(News.self)
    }
    
    func getRelatedNews(query: String)-> Results<News>{
//
        return realm.objects(News.self).filter("title CONTAINS[c] '" + query + "' OR title LIKE[c] '*" + query + "*'" + "OR content CONTAINS[c] '" + query + "' OR content LIKE[c] '*" + query + "*'" )
    }
    func addFav(news : News) {
        
        //prevent add same object
        try? realm.write() {
            realm.add(news,update:true)
        }
    }
    
    func removeFav(news : News){
        try! realm.write{
            realm.delete(news)
        }
    }
    
    func getAllQuote()->Results<Quote>{
        return realm.objects(Quote.self)
    }
    func getRelatedQuote(query: String)-> Results<Quote>{
        return realm.objects(Quote.self).filter("title CONTAINS[c] '" + query + "' OR title LIKE[c] '*" + query + "*'")
    }
    
    func addQuote(data : Quote) {
        //prevent add same object
        try? realm.write() {
            realm.add(data,update:true)
        }
    }
    
    func removeQuote(data : Quote){
        try! realm.write{
            realm.delete(data)
        }
    }
    
}
