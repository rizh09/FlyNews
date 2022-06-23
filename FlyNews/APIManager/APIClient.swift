//
//  JsonParser.swift
//  Tabbed app
//
//  Created by NHT Global on 20/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import Alamofire


class APIClient : NSObject{
    
    static let apiClient = APIClient()
    
    func apiRequest(_ url:String, _ method: HTTPMethod,
                    completion:@escaping ((Error?,Data?) -> Void)
        ){
        AF.request(url,method: method).responseJSON{response in
            
            switch(response.result){
            case .success:
//                if let json = response.value as? [String:Any] {
//                    print(json["data"] ?? "")
//                }
                completion(nil,response.data)
            case .failure:
                completion(response.error, nil)
            }
        }
    }
    
}


