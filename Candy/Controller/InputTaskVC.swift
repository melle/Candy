//
//  InputTaskVC.swift
//  Candy
//
//  Created by SimpuMind on 12/4/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class InputTaskVC: UIViewController {
    
    var taskManager: TaskManager?
    
    fileprivate lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var dismissButton: UIButton = {
       let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleTextField: KMPlaceholderTextView = {
        let tf = KMPlaceholderTextView()
        tf.font = UIFont(name: "Avenir-Black", size: 24)
        tf.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        tf.backgroundColor = .clear
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
     lazy var descriptionTextView: KMPlaceholderTextView = {
       let tf = KMPlaceholderTextView()
        tf.font = UIFont(name: "Avenir-Book", size: 14)
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var numberOfCharactersLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "140"
        label.font = UIFont(name: "Avenir-Book", size: 10)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Date-Time"
        label.font = UIFont(name: "Avenir-Black", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "Priority"
        label.font = UIFont(name: "Avenir-Black", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priorityButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var moreOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "More Options"
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.font = UIFont(name: "Avenir-Book", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var saveAlarmLabel: UILabel = {
        let label = UILabel()
        label.text = "Save as alarm"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "Avenir-Black", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saveASAlarmSwitch: UISwitch = {
       let control = UISwitch()
        control.onTintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    fileprivate lazy var saveNotifLabel: UILabel = {
        let label = UILabel()
        label.text = "Save as notification"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "Avenir-Black", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saveASNotifSwitch: UISwitch = {
        let control = UISwitch()
        control.onTintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        control.contentHorizontalAlignment = .right
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var saveTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy HH:mm:ss a"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskManager = TaskService.shared.taskManager
        
        view.backgroundColor = .white
        saveTaskButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        titleTextField.placeholder = "Title goes here..."
        descriptionTextView.placeholder = "Description goes here..."
        descriptionTextView.delegate = self
        titleTextField.delegate = self
        
        self.navigationItem.title = "N E W  T A S K"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1), NSAttributedStringKey.font: UIFont(name: "Avenir-Black", size: 16)!]
        
        let closeBarButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(dissmissVC))
        closeBarButton.tintColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        navigationItem.leftBarButtonItem = closeBarButton
        
        dateButton.addTarget(self, action: #selector(handleDateTimeSeletion), for: .touchUpInside)
        priorityButton.addTarget(self, action: #selector(handlePrioritySelection), for: .touchUpInside)
    }
    
    @objc func save(){
        guard
            let taskTitle = titleTextField.text,
            let taskDescription = descriptionTextView.text,
            let taskDate = dateButton.titleLabel?.text,
            let taskPriority = priorityButton.titleLabel?.text
        else {
            return
        }
        let date = dateFormatter.date(from: taskDate)
        let priority = (taskPriority == "High") ? 1 : 0
        let task = Task()
        task.title = taskTitle
        task.taskDescription = taskDescription
        task.timestamp = date!
        task.priority = priority
        self.taskManager?.addTask(task)
        dissmissVC()
    }
    
    @objc func handlePrioritySelection(){
        let titles = ["High", "Normal"]
        let picker =  ActionSheetStringPicker(title: title, rows: titles, initialSelection: 0, doneBlock: { (picker, index, item) in
            self.priorityButton.setTitle(item as? String, for: .normal)
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        picker?.show()
    }
    
    @objc func handleDateTimeSeletion(){
        let datePicker = ActionSheetDatePicker(title: "Date And Time:", datePickerMode: UIDatePickerMode.dateAndTime, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            let date = value as? Date
            let dateString = self.dateFormatter.string(from: date!)
            self.dateButton.setTitle(dateString, for: .normal)
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.minimumDate = Date()
        datePicker?.minuteInterval = 10
        
        datePicker?.show()
    }
    
    @objc func dissmissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    func configure(){
        [bannerView, descriptionTextView, numberOfCharactersLeftLabel,
         dateButton, dateTimeLabel, priorityLabel, priorityButton,
         moreOptionsLabel, saveASAlarmSwitch, saveASNotifSwitch,
         saveAlarmLabel, saveNotifLabel, saveTaskButton].forEach {view.addSubview($0)}
        [titleTextField].forEach {bannerView.addSubview($0)}
        
        bannerView.topAnchor.align(to: view.topAnchor)
        bannerView.leftAnchor.align(to: view.leftAnchor)
        bannerView.rightAnchor.align(to: view.rightAnchor)
        bannerView.heightAnchor.equal(to: 176)
        
        titleTextField.leftAnchor.align(to: bannerView.leftAnchor, offset: 20)
        titleTextField.rightAnchor.align(to: bannerView.rightAnchor, offset: -20)
        titleTextField.topAnchor.align(to: bannerView.topAnchor, offset: 10)
        titleTextField.bottomAnchor.align(to: bannerView.bottomAnchor, offset: -10)
        
        descriptionTextView.topAnchor.align(to: bannerView.bottomAnchor, offset: 20)
        descriptionTextView.leftAnchor.align(to: view.leftAnchor, offset: 20)
        descriptionTextView.rightAnchor.align(to: view.rightAnchor, offset: -20)
        descriptionTextView.heightAnchor.equal(to: 80)
        
        numberOfCharactersLeftLabel.topAnchor.align(to: descriptionTextView.bottomAnchor, offset: 8)
        numberOfCharactersLeftLabel.rightAnchor.align(to: view.rightAnchor, offset: -20)
        numberOfCharactersLeftLabel.widthAnchor.equal(to: 200)
        numberOfCharactersLeftLabel.heightAnchor.equal(to: 13)
        
        dateTimeLabel.topAnchor.align(to: numberOfCharactersLeftLabel.bottomAnchor, offset: 20)
        dateTimeLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        dateTimeLabel.widthAnchor.equal(to: 100)
        dateTimeLabel.heightAnchor.equal(to: 14)
        
        dateButton.topAnchor.align(to: dateTimeLabel.bottomAnchor, offset: 10)
        dateButton.leftAnchor.align(to: view.leftAnchor, offset: 20)
        dateButton.rightAnchor.align(to: view.rightAnchor, offset: -20)
        dateButton.heightAnchor.equal(to: 40)
        
        priorityLabel.topAnchor.align(to: dateButton.bottomAnchor, offset: 20)
        priorityLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        priorityLabel.widthAnchor.equal(to: 100)
        priorityLabel.heightAnchor.equal(to: 14)
        
        priorityButton.topAnchor.align(to: priorityLabel.bottomAnchor, offset: 10)
        priorityButton.leftAnchor.align(to: view.leftAnchor, offset: 20)
        priorityButton.rightAnchor.align(to: view.rightAnchor, offset: -20)
        priorityButton.heightAnchor.equal(to: 40)
        
        moreOptionsLabel.topAnchor.align(to: priorityButton.bottomAnchor, offset: 20)
        moreOptionsLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        moreOptionsLabel.rightAnchor.align(to: view.rightAnchor, offset: -20)
        moreOptionsLabel.heightAnchor.equal(to: 14)
        
        saveAlarmLabel.topAnchor.align(to: moreOptionsLabel.bottomAnchor, offset: 10)
        saveAlarmLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        saveAlarmLabel.widthAnchor.equal(to: 250)
        saveAlarmLabel.heightAnchor.equal(to: 35)
        
        saveASAlarmSwitch.topAnchor.align(to: moreOptionsLabel.bottomAnchor, offset: 10)
        saveASAlarmSwitch.rightAnchor.align(to: view.rightAnchor, offset: -20)
        
        saveNotifLabel.topAnchor.align(to: saveAlarmLabel.bottomAnchor, offset: 10)
        saveNotifLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        saveNotifLabel.widthAnchor.equal(to: 250)
        saveNotifLabel.heightAnchor.equal(to: 35)
        
        saveASNotifSwitch.topAnchor.align(to: saveASAlarmSwitch.bottomAnchor, offset: 10)
        saveASNotifSwitch.rightAnchor.align(to: view.rightAnchor, offset: -20)
        
        saveTaskButton.bottomAnchor.align(to: view.bottomAnchor, offset: -20)
        saveTaskButton.leftAnchor.align(to: view.leftAnchor, offset: 20)
        saveTaskButton.rightAnchor.align(to: view.rightAnchor, offset: -20)
        saveTaskButton.heightAnchor.equal(to: 35)
    }
}

extension InputTaskVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == descriptionTextView {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            numberOfCharactersLeftLabel.text = "\(140 - numberOfChars)"
             return numberOfChars < 140
        }else if textView == titleTextField {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            return numberOfChars < 40
        }else{
            return false
        }
    }
}
