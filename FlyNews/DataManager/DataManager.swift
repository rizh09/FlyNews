//
//  DataManager.swift
//  Tabbed app
//
//  Created by NHT Global on 21/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager : NSObject{
    static let instance = DataManager()
    private let apiClient:APIClient
    
    public override init(){
        apiClient = APIClient()
    }
    func fetchFeeds(url:String,completion:@escaping((Error?,[News]?) -> Void)){
        apiClient.apiRequest(url, .get){err,jsonData  in
            
            guard
                err == nil,
                let data = jsonData
                else{
                    return completion(err, nil)
            }
            
            let json = JSON(data)
            let jsonObjectList = json["articles"].arrayValue
            var articles = [News]()
            
            for i in jsonObjectList{
                let p = News.construct(json: i)
                //                let c : String? =  p?.addr?.code
                articles.append(p)
            }
            
            completion(nil,articles)
            
        }
    }
    
    func fetchEverythings(url:String,completion:@escaping((Error?,[News]?) -> Void)){
        if let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            apiClient.apiRequest(encodedUrl, .get){err,jsonData  in
                guard
                    err == nil,
                    let data = jsonData
                    else{
                        return completion(err, nil)
                }
                
                let json = JSON(data)
                let jsonObjectList = json["articles"].arrayValue
                var articles = [News]()
                
                for i in jsonObjectList{
                    let p = News.construct(json : i)
                    //                let c : String? =  p?.addr?.code
                    articles.append(p)
                }
                completion(nil,articles)
                
            }
        }
    }
    
    func fetchGif(url:String,completion:@escaping((Error?,[ImageContent]?)->Void)){
        if let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            apiClient.apiRequest(encodedUrl, .get){err,jsonData  in
                guard
                    err == nil,
                    let data = jsonData
                    else{
                        return completion(err, nil)
                }
                
                let json = JSON(data)
                let jsonObjectList = json["data"].arrayValue
                var articles = [ImageContent]()
                
                for i in jsonObjectList{
                    let p = ImageContent.construct(json : i)
                    //                let c : String? =  p?.addr?.code
                    articles.append(p)
                }
                completion(nil,articles)
                
            }
        }
    }
    
}
