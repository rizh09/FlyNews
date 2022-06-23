//
//  FirstViewController.swift
//  Tabbed app
//
//  Created by NHT Global on 20/5/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import UIKit
import DropDown
class HomeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    let countryCode = ["hk","jp","us","tw","cn"]
    let country = ["🇭🇰香港","🇯🇵日本","🇺🇸United Stated","🇹🇼台灣","🇨🇳中國"]
    
    let countryDropDown = DropDown()
    private var dataList: [News]?
    
    @IBOutlet weak var countryBarBtnItem: UIBarButtonItem!
    @IBOutlet weak var mTableView: UITableView!
    @IBAction func showCountry(_ sender: Any) {
        countryDropDown.show()
    }
    
    var refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataList = [News]()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCellIdentifier")
        fetchData(countryCode: self.getSavedMarket())
        setupCountryDropDown()
        setupNav()
        setupRefreshController()
        
    }
    func getSavedMarket() ->String{
        return Utils.shared.getUserDefault(key: NewsCountryCode)
    }
    func setupRefreshController(){
        
        //binding to tableView
        if #available(iOS 10.0, *) {
            mTableView.refreshControl = refreshController
        } else {
            mTableView.addSubview(refreshController)
        }
        
        //add action and target
        refreshController.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        
    }
    @objc func pullToRefresh(){
        
        fetchData(countryCode: self.getSavedMarket())
    }
    
    func setupNav(){
        
        //        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Breaking News"
    }
    
    func setupCountryDropDown(){
        countryDropDown.anchorView = countryBarBtnItem
        countryDropDown.dataSource = country
        
        //initliaze the country text
        
        let indexCountry = countryCode.firstIndex(of: getSavedMarket()) ?? 0
        self.countryBarBtnItem.title = country[indexCountry]
        
        countryDropDown.selectionAction = {(index: Int, item: String) in
            Utils.shared.logInfo("Selected item: \(item) at index: \(index)")
            self.countryBarBtnItem.title = item
            
            self.beginToRefresh()
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseIn, animations: {self.mTableView.contentOffset = CGPoint(x:0,y:-self.refreshController.bounds.height)}, completion: { (finish) in
                self.fetchData(countryCode:self.countryCode[index])
            })
            Utils.shared.saveUserDefault(value:self.countryCode[index],  key: NewsCountryCode)
        }
        countryDropDown.width = 200
        countryDropDown.direction = .any
        
        
    }
    
    func beginToRefresh(){
        self.refreshController.beginRefreshing()
        
    }
    
    func endRefreshing(){
        if(self.refreshController.isRefreshing){
            self.refreshController.endRefreshing()
        }
        //        self.mTableView.scrollToRow(at: IndexPath(row:0,section:0), at: .top, animated: true)
        
    }
    func fetchData(countryCode:String){
        
        
        
        Utils.shared.logInfo(countryCode)
        DataManager.instance.fetchFeeds(url: APIEndPoint.instance.getTopHeadLines(countryCode),completion: {err, data in
            
            if( err == nil){
                
                self.dataList = data!
                self.mTableView?.reloadData()
                self.endRefreshing()
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
            controller.pageType = homePage
        }
    }
    
    
}

