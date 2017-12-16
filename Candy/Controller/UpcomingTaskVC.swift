//
//  UpcomingTaskVC.swift
//  Candy
//
//  Created by SimpuMind on 12/15/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class UpcomingTaskVC: UIViewController {

    var taskManager = TaskManager()
    
    fileprivate var searchBar: UISearchBar!
    var searchActive : Bool = false
    var searchBarButton: UIBarButtonItem!
    
    var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming tasks —"
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.font = UIFont(name: "Avenir-Black", size: 24)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var taskTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        taskManager = TaskService.shared.getAllTaskGroupedByDate()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.navigationItem.title = "S C H E D U L E R"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 16)!]

        searchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_line"), style: .plain, target: self, action: #selector(handleSearch))
        self.navigationItem.rightBarButtonItem = searchBarButton
        searchBarButton.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        configureViews()
    }
    
    @objc func handleSearch(){
        self.navigationItem.titleView = self.searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(configureNavigationBar))
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        self.searchActive = true
    }
    
    @objc func configureNavigationBar(){
        searchActive = false
        self.navigationItem.titleView = nil
        self.navigationItem.title = "S C H E D U L E R"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 16)!]
        searchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_line"), style: .plain, target: self, action: #selector(handleSearch))
        self.navigationItem.rightBarButtonItem = searchBarButton
        searchBarButton.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
    }
    
    func configureViews(){
        [bannerView, taskTableView].forEach{view.addSubview($0)}
        [titleLabel].forEach{bannerView.addSubview($0)}
        
        bannerView.topAnchor.align(to: view.topAnchor)
        bannerView.leftAnchor.align(to: view.leftAnchor)
        bannerView.rightAnchor.align(to: view.rightAnchor)
        bannerView.heightAnchor.equal(to: 176)
        
        titleLabel.leftAnchor.align(to: bannerView.leftAnchor, offset: 10)
        titleLabel.widthAnchor.equal(to: 160)
        titleLabel.heightAnchor.equal(to: 96)
        titleLabel.centerYAnchor.align(to: bannerView.centerYAnchor, offset: 30)
        
        taskTableView.topAnchor.align(to: bannerView.bottomAnchor)
        taskTableView.leftAnchor.align(to: view.leftAnchor)
        taskTableView.rightAnchor.align(to: view.rightAnchor)
        taskTableView.bottomAnchor.align(to: view.bottomAnchor)
    }
}

extension UpcomingTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskManager.groupedTasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.groupedTasks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        let task = taskManager.groupedTasks[indexPath.section][indexPath.item]
        cell.textLabel?.text = task.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let task = taskManager.groupedTasks[section][0]
        let dateString = dateFormatter.string(from: task.timestamp)
        return dateString
    }
}
