//
//  QuoteViewController.swift
//  FlyNews
//
//  Created by NHT Global on 4/6/2019.
//  Copyright © 2019 tester. All rights reserved.
//

import UIKit
import RealmSwift

class QuoteViewController : UIViewController  ,UITableViewDataSource,UITableViewDelegate, UISearchResultsUpdating,UISearchBarDelegate{
    
    
    @IBAction func addQuote(_ sender: UIBarButtonItem) {
        showInputDialog()
    }
    @IBOutlet weak var mTableView: UITableView!
    private var dataList : Results<Quote>?
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Save into mobile", message: "Enter sth..", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let title = alertController.textFields?[0].text
            let urlImage = alertController.textFields?[1].text ?? ""
            
            print(urlImage)
            self.insertIntoQuote(title: title!,urlImage:urlImage)
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Title"
        }
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Image Url .jpg etc - Optional"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func insertIntoQuote(title:String,urlImage:String){
        RealmManager.shared.addQuote(data: Quote.construct(title: title,date:self.getCurrentDate(),urlImage : urlImage))
        
        self.mTableView.beginUpdates()
        self.mTableView.insertRows(at: [IndexPath(row:self.dataList!.count-1 ,section:0)], with: .automatic)
        self.mTableView.endUpdates()
    }
    
    func getCurrentDate() ->String {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate = format.string(from: date)
        
        return formattedDate
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCellIdentifier")
        setupNavAndSearch()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    let searchController =  UISearchController(searchResultsController: nil)
    
    func setupNavAndSearch(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Note"
        navigationItem.searchController = searchController
        
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "search.."
        searchController.searchBar.delegate = self
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
        cell.labelDate.text = obj.date
        cell.imageBanner.kf.setImage(with: URL(string:obj.urlImage ?? ""))
        
        cell.hideCopyBtn()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            RealmManager.shared.removeQuote(data: self.dataList![indexPath.row])
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dataList = RealmManager.shared.getRelatedQuote(query: searchBar.text ?? "")
        mTableView.reloadData()
    }
    func fetchData(){
        dataList = RealmManager.shared.getAllQuote()
        mTableView.reloadData()
    }
    
}
