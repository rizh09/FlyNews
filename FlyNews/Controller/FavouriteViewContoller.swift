//
//  FavouriteViewContoller.swift
//  Tabbed app
//
//  Created by NHT Global on 23/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class FavouriteViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    
    @IBOutlet weak var mTableView: UITableView!
    private var dataList: Results<News>?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchLocalList(keywords: searchBar.text ?? "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCellIdentifier")
        
        setupNavAndSearch()
    }
    
    func setupNavAndSearch(){
        self.navigationItem.title = "Favourite"
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "search.."
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    func searchLocalList(keywords:String){
        
        dataList = RealmManager.shared.getRelatedNews(query: keywords)
        mTableView.reloadData()
    }
    func fetchData(){
        dataList =  RealmManager.shared.getAllNews()
        mTableView.reloadData()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController,
            let index = mTableView.indexPathForSelectedRow?.row,
            dataList!.count>index{
            controller.content = dataList![index]
            controller.pageType = favPage
        }
    }
    
}
