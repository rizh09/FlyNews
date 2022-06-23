//
//  SecondViewController.swift
//  Tabbed app
//
//  Created by NHT Global on 20/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import UIKit

class ExlporeViewController: UIViewController  ,UITableViewDataSource,UITableViewDelegate, UISearchResultsUpdating,UISearchBarDelegate{
    

    private var dataList: [News]?
    
    let searchController =  UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var mTableView: UITableView!
    let refreshController = UIRefreshControl()
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        Utils.shared.logInfo(searchBar.text ?? "")
        fetchData(keywords:searchBar.text ?? "")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataList = [News]()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCellIdentifier")
        fetchData(keywords:"world")
        setupNavAndSearchBar()
        
    }
    func setupNavAndSearchBar(){
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "World"
        navigationItem.searchController = searchController
        
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "search.."
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    func fetchData(keywords:String){
        DataManager.instance.fetchEverythings(url: APIEndPoint.instance.getEverything(keywords),completion: {err, data in
            if( err == nil){
                self.dataList = data
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
        return self.dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellIdentifier")! as! CustomContentCell
        
        let obj = dataList![indexPath.row]
        
        cell.labelTitle.text = obj.title
        cell.labelDate.text = obj.publishedAt
        cell.imageBanner.kf.setImage(with: URL(string:obj.urlToImage ?? ""))
        cell.hideCopyBtn()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "DetailView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?) {
        
        if let controller = segue.destination as? DetailViewController,
            let index = mTableView.indexPathForSelectedRow?.row,
            dataList!.count > index{
            controller.content = dataList![index]
            controller.pageType = explorePage
        }
    }
}

