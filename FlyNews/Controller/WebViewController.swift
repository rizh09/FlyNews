//
//  WebViewController.swift
//  Tabbed app
//
//  Created by NHT Global on 24/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    
    
    var webView:WKWebView!
    
    var strUrl: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        loadUrl(strUrl)
    }
    
    func setupWebView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    func loadUrl(_ mUrl : String?){
        if  let data = mUrl{
            let request = URLRequest(url:URL(string:data)!)
            webView.load(request)
            //            mWebViewContainer?.load(URLRequest(url:url))
        }else{
            Utils.shared.showToast(text: "no source", view: self.view)
        }
    }
    
}
