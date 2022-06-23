//
//  SearchImageViewController.swift
//  FlyNews
//
//  Created by NHT Global on 27/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,CustomCellDelegate {
    
    var keywords = "hot"
    func didCopy(_ gifUrl: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = gifUrl
        Utils.shared.showToast(text: "copied", view: self.view)
    }
    
    
    
    let searchController =  UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var mTableView: UITableView!
    private var dataList = [ImageContent]()
    
    let limit = 20
    var offset = 0
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.offset = 0
        Utils.shared.logInfo(searchBar.text ?? "")
        fetchData(keywords:searchBar.text ?? "",action: FetchAction.pull)
        
        keywords = searchBar.text ?? ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCellIdentifier")
        
        setupNavAndSearch()
        fetchData(keywords:keywords,action: FetchAction.pull)
    }
    func setupNavAndSearch(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "GIPHY.com"
        navigationItem.searchController = searchController
        
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "search.."
        searchController.searchBar.delegate = self
    }
    enum FetchAction{
        case pull
        case append
    }
    
    
    func fetchData(keywords:String,action :FetchAction){
        
        if(action == FetchAction.append){
            self.offset += self.limit
        }else{
            self.offset = 0
        }
        
        print(APIEndPoint.instance.getGifSearch(keywords,offset,self.limit))
        DataManager.instance.fetchGif(url: APIEndPoint.instance.getGifSearch(keywords, offset,self.limit), completion: {err,data in
            if( err == nil){
                
                if(action == FetchAction.pull){
                    self.dataList = data!
                    
                    print("pull");
                }else{
                    self.dataList += data!
                    print("append");
                }
                
                
                self.mTableView?.reloadData()
            
            
            }else{
                print(err ?? "error is unhandle")
            }
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellIdentifier")! as! CustomContentCell
        
        //        let obj = dataList![indexPath.row]
        let obj = dataList[indexPath.row]
        
        cell.labelTitle.text = obj.title
        cell.imageBanner.kf.setImage(with: URL(string:obj.preview_gif ?? ""))
        cell.labelDate.text = ""
        cell.gifUrl = obj.original
        cell.cellDelegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        let last = dataList!.count - 1
        let last = dataList.count - 1
        if indexPath.row == last{
            fetchData(keywords:keywords,action: FetchAction.append)
        }
    }
}
