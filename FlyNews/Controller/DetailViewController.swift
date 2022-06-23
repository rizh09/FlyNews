//
//  DetailViewController.swift
//  Tabbed app
//
//  Created by NHT Global on 20/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import UIKit
import Kingfisher


class DetailViewController: UIViewController {
    
 
    var pageType :String!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelSource: UILabel!
    @IBAction func bookmarkBtn(_ sender: Any) {
        
        Utils.shared.logInfo(pageType)
        if(pageType == favPage){
            self.removeFromFav()
        }else{
            self.addToFav()
        }
    }
    @IBAction func visitWebSrc(_ sender: Any) {
        self.performSegue(withIdentifier: "webViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? WebViewController,
            let mUrl = content?.url{
            controller.strUrl = mUrl
        }
    }
    var content :News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if content == nil {
            
            let alertController = UIAlertController(title:"Hint",message:"record is expired",preferredStyle:.alert)
            let alertAction = UIAlertAction(title:"ok",style:.cancel,handler:nil)
            alertController.addAction(alertAction)
            present(alertController,animated: true,completion: nil)
            return
        }
        
        self.labelTitle.text = content?.title ?? ""
        self.labelContent.text = content?.content ?? content?.desc ?? ""
        self.labelSource.text = content?.source_name ?? ""
        self.imageView.kf.setImage(with: URL(string:content?.urlToImage ?? ""))
        
        setupNav()
    }
    
    
    func setupNav(){
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func addToFav(){
        if( content == nil ) {
            return
        }else{
            
            Utils.shared.showToast(text:"Added",view:self.view)
            RealmManager.shared.addFav(news: content!)
        }
    }
    func removeFromFav(){
        
        Utils.shared.showToast(text:"Removed",view:self.view)
        RealmManager.shared.removeFav(news: content!)
    }
    
}
