//
//  APIEndPoint.swift
//  Tabbed app
//
//  Created by NHT Global on 22/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation


let api_key = "1aa9a87214eb41bd891496f72d346a3c"
let apikey = "apiKey=" + api_key
let host = "https://newsapi.org/v2/"
let top_headlines = "top-headlines?"+apikey
let everything = "everything?"+apikey
let sortByPopularity = "&sortBy=popularity"


let gifHost = "https://api.giphy.com"
let searchPath = "/v1/gifs/search?" + giphyAPI_KEY
let giphyAPI_KEY = "api_key=6FO2XuUjfKiN9626Ok4h1pM0DKvszMAz"

public class APIEndPoint : NSObject {
    
    
    static let instance = APIEndPoint()
    
    public override init() {
    }
    func getTopHeadLines(_ country : String) -> String{
        return host + top_headlines + "&country=" + country
    }
    func getEverything(_ keywords : String) -> String{
        return host + everything  + sortByPopularity + "&q=" + keywords
    }
    
    func getGifSearch(_ keywords : String,_ offset : Int,_ limit :Int) -> String{
       
        return gifHost + searchPath  + "&q=" + keywords + "&offset=" + "\(offset)" + "&limit=" + "\(limit)"
    }
}

