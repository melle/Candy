//
//  TaskCell.swift
//  Candy
//
//  Created by SimpuMind on 12/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

protocol TaskDelegate: class {
    func deleteTask(indexPath: IndexPath)
    func editTask(indexPath: IndexPath)
    func markTaskAsDone(indexPath: IndexPath)
}

class TaskCell: UITableViewCell {
    
    var delegate: TaskDelegate?
    var indexPath = IndexPath()
    var taskListVc: ListVC?
    
    fileprivate lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
        label.font = UIFont(name: "Avenir-Black", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 3
        label.sizeToFit()
        label.font = UIFont(name: "Avenir-Book", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.text = "time"
        label.textAlignment = .right
        label.addImage(imageName: "alarm", afterLabel: false)
        label.font = UIFont(name: "Avenir-Book", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.text = "date"
        label.addImage(imageName: "calender", afterLabel: false)
        label.font = UIFont(name: "Avenir-Book", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var dividerVieW: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var markTasDonekButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1).cgColor
        button.layer.borderWidth = 0.7
        button.layer.cornerRadius = 30 / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }()
    
    fileprivate lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //configure()
        markTasDonekButton.addTarget(self, action: #selector(handlePriorityButtonClicked), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(handleDeleteTask), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //configure()
    }
    
    func configCell(with task: Task, indexPath: IndexPath, checked: Bool){
        self.indexPath = indexPath
        
        titleLabel.text = task.title
        descriptionLabel.text = task.taskDescription
        
        dateLabel.text = dateFormatter.string(from: task.timestamp)
        timeLabel.text = timeFormatter.string(from: task.timestamp)
        
        changePriorityBackgroundColorForDoneTask(checked: checked)
        
        configure()
    }
    
    @objc func handlePriorityButtonClicked(){
        delegate?.markTaskAsDone(indexPath: indexPath)
    }
    
    @objc func handleDeleteTask(){
        if let window = UIApplication.shared.delegate?.window {
            let vc = window?.rootViewController
            vc?.showAlertWithOk(withTitle: "Delete Task", message: "Are you sure you want to delete this task?", completion: {
                self.delegate?.deleteTask(indexPath: self.indexPath)
            })
        }
    }
    
    func changePriorityBackgroundColorForDoneTask(checked: Bool){
        if checked{
            markTasDonekButton.backgroundColor =  #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1)
            markTasDonekButton.layer.borderColor = UIColor.white.cgColor
        }else{
            markTasDonekButton.backgroundColor = .white
            markTasDonekButton.layer.borderColor = #colorLiteral(red: 0.1411764706, green: 0.231372549, blue: 0.4196078431, alpha: 1).cgColor
        }
    }
    
    private func configure() {
        [titleLabel, descriptionLabel, timeLabel,
         dateLabel, dividerVieW, editButton
            , deleteButton, markTasDonekButton].forEach {addSubview($0)}
        
        let descriptionHeight
            = rectForText(text: descriptionLabel.text ?? "", font: UIFont(name: "Avenir-Book", size: 14)!, maxSize: CGSize(width: frame.width - 18, height: 1000))
        
        markTasDonekButton.leftAnchor.align(to: leftAnchor, offset: 8)
        markTasDonekButton.centerYAnchor.align(to: centerYAnchor)
        markTasDonekButton.widthAnchor.equal(to: 30)
        markTasDonekButton.heightAnchor.equal(to: 30)
        
        timeLabel.topAnchor.align(to: topAnchor, offset: 8)
        timeLabel.rightAnchor.align(to: rightAnchor, offset: -8)
        timeLabel.widthAnchor.equal(to: 200)
        timeLabel.heightAnchor.equal(to: 14)
        
        titleLabel.topAnchor.align(to: timeLabel.bottomAnchor, offset: 2)
        titleLabel.leftAnchor.align(to: markTasDonekButton.rightAnchor, offset: 8)
        titleLabel.rightAnchor.align(to: rightAnchor, offset: -8)
        titleLabel.heightAnchor.equal(to: 17)
        
        descriptionLabel.topAnchor.align(to: titleLabel.bottomAnchor, offset: 3)
        descriptionLabel.leftAnchor.align(to: markTasDonekButton.rightAnchor, offset: 8)
        descriptionLabel.rightAnchor.align(to: rightAnchor, offset: -8)
        descriptionLabel.heightAnchor.equal(to: descriptionHeight.height)
        
        dateLabel.bottomAnchor.align(to: bottomAnchor, offset: -12)
        dateLabel.leftAnchor.align(to: markTasDonekButton.rightAnchor, offset: 8)
        dateLabel.widthAnchor.equal(to: 400)
        dateLabel.heightAnchor.equal(to: 12)
        
        deleteButton.bottomAnchor.align(to: bottomAnchor, offset: -12)
        deleteButton.rightAnchor.align(to: rightAnchor, offset: -8)
        deleteButton.widthAnchor.equal(to: 30)
        deleteButton.heightAnchor.equal(to: 30)
        
        editButton.bottomAnchor.align(to: bottomAnchor, offset: -12)
        editButton.rightAnchor.align(to: deleteButton.leftAnchor, offset: -8)
        editButton.widthAnchor.equal(to: 30)
        editButton.heightAnchor.equal(to: 30)
        
        dividerVieW.bottomAnchor.align(to: bottomAnchor, offset: -4)
        dividerVieW.leftAnchor.align(to: leftAnchor)
        dividerVieW.rightAnchor.align(to: rightAnchor)
        dividerVieW.heightAnchor.equal(to: 1)
        
    }
    
    func rectForText(text: String, font: UIFont, maxSize: CGSize) -> CGRect {
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: text).boundingRect(with: maxSize, options: options, attributes: [NSAttributedStringKey.font: font], context: nil)
        return estimatedRect
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
