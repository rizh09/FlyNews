//
//  Util.swift
//  Tabbed app
//
//  Created by NHT Global on 23/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import Toast_Swift


let NewsCountryCode = "NewsCountryCode"
let favPage = "FavPage"
let homePage = "HomePage"
let explorePage = "ExplorePage"

public class Utils : NSObject{
    static let shared = Utils()
    let mUserDefaults = UserDefaults.standard
    func saveUserDefault(value:String,key:String){
        mUserDefaults.set(value,forKey:key)
    }
    func getUserDefault(key:String)-> String{
        if(key == NewsCountryCode){
            return mUserDefaults.string(forKey:NewsCountryCode) ?? "hk"
        }
        return mUserDefaults.string(forKey:key) ?? ""
        
    }
    
    func showToast(text:String,view:UIView){
        view.makeToast(text)
    }
    
    func logInfo(_ text:String){
        print("Info :" , text)
    }
    
    
}
