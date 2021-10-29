//
//  addNewTodoView.swift
//  MyTODO
//
//  Created by nju on 2021/10/19.
//

import UIKit

class todoItemInfoView: UIView, UITableViewDelegate, UITableViewDataSource {

    //MARK: static
    static var tableViewCellIdentifier : String = NSStringFromClass(itemInfoTableViewCell.self)
    static var tableViewFooterIdentifier : String = NSStringFromClass(itemInfoTableViewFooter.self)
    static var footerDefaultText : String = "在此输入事件描述"
    lazy var cellParamsArrays : NSMutableArray = {
        var array  = NSMutableArray.init(array: [
            NSMutableArray.init(array: ["Name", "event", addNewItemTableViewCellType.cellTypeTextField, ""]),
            NSMutableArray.init(array: ["Date", "date", addNewItemTableViewCellType.cellTypeMoreAction, Date.now]),
            NSMutableArray.init(array: ["Checked?", "check", addNewItemTableViewCellType.cellTypeSwitch, false]),
            NSMutableArray.init(array: ["Description", "description", addNewItemTableViewCellType.cellTypeDefault, ""])
        ])
        return array
    }()
    
    lazy var itemInfoTableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
    lazy var dateFormatter : DateFormatter = {
        let dateformatter = DateFormatter.init()
        dateformatter.dateFormat = "yyyy-MM-dd"
        return dateformatter
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: init
    init() {
        super.init(frame: CGRect.zero)
    }
    
    init(name: String, date: Date, checked: Bool, description: String) {
        super.init(frame: CGRect.zero)
        (self.cellParamsArrays[0] as! NSMutableArray).replaceObject(at: 3, with: name)
        (self.cellParamsArrays[1] as! NSMutableArray).replaceObject(at: 3, with: date)
        (self.cellParamsArrays[2] as! NSMutableArray).replaceObject(at: 3, with: checked)
        (self.cellParamsArrays[3] as! NSMutableArray).replaceObject(at: 3, with: description)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.itemInfoTableView)
        self._setupUI()
    }

    //MARK: setupUI
    private func _setupUI() {
        self.itemInfoTableView.register(itemInfoTableViewCell.self, forCellReuseIdentifier: todoItemInfoView.tableViewCellIdentifier)
        self.itemInfoTableView.register(itemInfoTableViewFooter.self, forHeaderFooterViewReuseIdentifier: todoItemInfoView.tableViewFooterIdentifier)
        self.itemInfoTableView.delegate = self;
        self.itemInfoTableView.dataSource = self;

        self._setupConstraints()
        
    }
    
    private func _setupConstraints() {
        self.itemInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        self.itemInfoTableView.autoresizesSubviews = false
        
        let tableViewTopConstraint = NSLayoutConstraint.init(item: self.itemInfoTableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0);
        tableViewTopConstraint.isActive = true
        
        let tableViewLeftConstraint = NSLayoutConstraint.init(item: self.itemInfoTableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0);
        tableViewLeftConstraint.isActive = true
        
        let tableViewRightConstraint = NSLayoutConstraint.init(item: self.itemInfoTableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        tableViewRightConstraint.isActive = true
        
        let tableViewBottomConstraint = NSLayoutConstraint.init(item: self.itemInfoTableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 2, constant: 0)
        tableViewBottomConstraint.isActive = true
    }
    
    //MARK: tableview delegate
    
    
    
    //MARK: tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellParamsArrays.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellParamsArray : NSArray = self.cellParamsArrays[indexPath.row] as! NSMutableArray
        let cell = itemInfoTableViewCell.init(iconImageName: cellParamsArray[1] as! String ,
                                                name: cellParamsArray[0] as! String,
                                                type: cellParamsArray[2] as! addNewItemTableViewCellType,
                                                style: UITableViewCell.CellStyle.default,
                                              reuserIdentifier: todoItemInfoView.tableViewCellIdentifier)
        switch indexPath.row{
        case 0:
            cell.textFieldDefaultText = "在此输入事件名"
            cell.detailTextField.text = (cellParamsArray[3] as! String)
            break
        case 1:
            weak var weakSelf = self
            cell.didClickCellBlk = {
                weakSelf!._handleClickDatePick(cell: cell, indexPath: indexPath)
            }
            cell.detailTextField.text = self.dateFormatter.string(from: cellParamsArray[3] as! Date)
            break
        case 2:
            cell.switchButton.setOn(cellParamsArray[3] as! Bool, animated: false)
            break
        default: break
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = itemInfoTableViewFooter.init(defaultText: todoItemInfoView.footerDefaultText,
                                                    resuerIdetifier: todoItemInfoView.tableViewFooterIdentifier)
        let descriptionText = ((self.cellParamsArrays[3] as! NSMutableArray)[3] as! String)
        if descriptionText != "" {
            footer.descriptionTextView.text = descriptionText
        }
        return footer
    }
    
    //MARK: public methods
    func getNameText() -> String {
        let _indexPath = IndexPath.init(row: 0, section: 0)
        let nameCell : itemInfoTableViewCell = self.itemInfoTableView.cellForRow(at: _indexPath) as! itemInfoTableViewCell
        return nameCell.detailTextField.text!
    }
    
    func getIsCheck() -> Bool {
        let _indexPath = IndexPath.init(row: 2, section: 0)
        let checkCell : itemInfoTableViewCell = self.itemInfoTableView.cellForRow(at: _indexPath) as! itemInfoTableViewCell
        return checkCell.switchButton.isOn
    }
    
    func getDate() -> Date {
        let _indexPath = IndexPath.init(row: 1, section: 0)
        let dateCell : itemInfoTableViewCell = self.itemInfoTableView.cellForRow(at: _indexPath) as! itemInfoTableViewCell
        return self.dateFormatter.date(from: dateCell.detailTextField.text!) ?? Date.now
    }
    
    func getDecription() -> String {
        let footer : itemInfoTableViewFooter = self.itemInfoTableView.footerView(forSection: 0) as! itemInfoTableViewFooter
        if(footer.descriptionTextView.text == todoItemInfoView.footerDefaultText) {
            return ""
        }
        else {
            return footer.descriptionTextView.text!
        }
    }
    
    //MARK: private methods
    private func _getViewController() -> UIViewController? {
    // get the viewController of current view
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    private func _handleClickDatePick(cell: itemInfoTableViewCell, indexPath: IndexPath) {
        let alertVC = UIAlertController.init(title: "Select Date", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker.init()

        
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        if cell.detailTextField.text == "" {
            datePicker.date = .now
        }
        else {
            datePicker.date = self.dateFormatter.date(from: cell.detailTextField.text!) ?? .now
        }
        alertVC.view.addSubview(datePicker)
        
        alertVC.view.autoresizesSubviews = false
        alertVC.view.translatesAutoresizingMaskIntoConstraints = false
        alertVC.view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        datePicker.autoresizesSubviews = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerXAnchor.constraint(equalTo: alertVC.view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alertVC.view.topAnchor, constant: 20).isActive = true
        
        let confirmAction = UIAlertAction.init(title: "Confirm", style: .default, handler: {_ in

            cell.detailTextField.text = self.dateFormatter.string(from: datePicker.date)
        })
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        
        alertVC.addAction(confirmAction)
        alertVC.addAction(cancelAction)
        
        self._getViewController()?.present(alertVC, animated: true, completion: nil)
    }
}
