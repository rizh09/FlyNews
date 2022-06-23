//
//  DateHelper.swift
//  Tabbed app
//
//  Created by NHT Global on 22/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation


public class DateHelper:NSObject{
    
    static let shared = DateHelper()
    
    func DateConverter(_ date:String) -> String{
        
        let dateFormatter = DateFormatter()
        //recevied date type
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateType = dateFormatter.date(from:date)else
        {
            return ""
        }
        //converter expected format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from:dateType)
    }
}
