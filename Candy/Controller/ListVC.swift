//
//  ListVC.swift
//  Candy
//
//  Created by SimpuMind on 12/2/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    fileprivate var searchBar: UISearchBar!
    var searchActive : Bool = false
    var searchBarButton: UIBarButtonItem!
    
    var dataProvider: TaskListDataProvider!
    var taskManager = TaskManager()
    
    var sortOptions = ["Priority - High", "Priority - Normal"]
    
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    var bannerView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Today’s list —"
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.font = UIFont(name: "Avenir-Black", size: 24)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dropDownButton: UIButton = {
       let button = UIButton()
        button.setTitle("⏚", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var taskTableView: UITableView = {
       let tv = UITableView()
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        dataProvider = TaskListDataProvider()
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        taskTableView.delegate = dataProvider
        taskTableView.dataSource = dataProvider
        
        dataProvider.taskManager = TaskService.shared.taskManager
        
        //taskTableView.estimatedRowHeight = 250
        taskTableView.rowHeight = 150
        taskTableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        self.navigationItem.title = "T O - D O"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 16)!]
        
        searchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_line"), style: .plain, target: self, action: #selector(handleSearch))
        self.navigationItem.rightBarButtonItem = searchBarButton
        searchBarButton.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        configureViews()
        
        dropDownButton.addTarget(self, action: #selector(handleDropDown), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(notification:)), name: .reloadListVC, object: nil)
    }
    
    @objc func handleSearch(){
        self.navigationItem.titleView = self.searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(configureNavigationBar))
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        self.searchActive = true
    }
    
    @objc func handleDropDown(){
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 135))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        self.popover = Popover(options: self.popoverOptions)
        DispatchQueue.main.async {
            tableView.sizeToFit()
            self.popover.show(tableView, fromView: self.dropDownButton)
        }
    }
    
    @objc func configureNavigationBar(){
        searchActive = false
        self.navigationItem.titleView = nil
        self.navigationItem.title = "T O - D O"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 16)!]
        searchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_line"), style: .plain, target: self, action: #selector(handleSearch))
        self.navigationItem.rightBarButtonItem = searchBarButton
        searchBarButton.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTableView.reloadData()
    }
    
    func configureViews(){
        [bannerView, taskTableView].forEach{view.addSubview($0)}
        [titleLabel, dropDownButton].forEach{bannerView.addSubview($0)}
        
        bannerView.topAnchor.align(to: view.topAnchor)
        bannerView.leftAnchor.align(to: view.leftAnchor)
        bannerView.rightAnchor.align(to: view.rightAnchor)
        bannerView.heightAnchor.equal(to: 176)
        
        dropDownButton.rightAnchor.align(to: bannerView.rightAnchor, offset: -10)
        dropDownButton.widthAnchor.equal(to: 45)
        dropDownButton.heightAnchor.equal(to: 45)
        dropDownButton.centerYAnchor.align(to: bannerView.centerYAnchor, offset: 30)
        
        titleLabel.leftAnchor.align(to: bannerView.leftAnchor, offset: 10)
        titleLabel.widthAnchor.equal(to: 100)
        titleLabel.heightAnchor.equal(to: 96)
        titleLabel.centerYAnchor.align(to: bannerView.centerYAnchor, offset: 30)
        
        taskTableView.topAnchor.align(to: bannerView.bottomAnchor)
        taskTableView.leftAnchor.align(to: view.leftAnchor)
        taskTableView.rightAnchor.align(to: view.rightAnchor)
        taskTableView.bottomAnchor.align(to: view.bottomAnchor)
    }
}

extension ListVC {
    @objc func reloadTableView(notification: NSNotification) {
        taskTableView.reloadData()
    }
}

extension ListVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        //tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        filtered = vendors.filter { (vendor) -> Bool in
//            let tmp: NSString = vendor.paper_name! as NSString
//            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//            return range.location != NSNotFound
//        }
        //self.tableView.reloadData()
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont(name: "Avenir-Black", size: 14)
        cell.textLabel?.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        cell.textLabel?.text = sortOptions[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = sortOptions[indexPath.item]
        
        self.popover.dismiss()
    }
}

