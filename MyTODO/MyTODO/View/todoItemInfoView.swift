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
    static var cellParamsArrays : NSArray = {
        var array  = NSArray.init(array: [
            ["Name", "event", addNewItemTableViewCellType.cellTypeTextField],
            ["Date", "date", addNewItemTableViewCellType.cellTypeMoreAction],
            ["Checked?", "check", addNewItemTableViewCellType.cellTypeSwitch],
            ["Description", "description", addNewItemTableViewCellType.cellTypeDefault]
        ])
        return array
    }()
    
    lazy var itemInfoTableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
        return todoItemInfoView.cellParamsArrays.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellParamsArray : NSArray = todoItemInfoView.cellParamsArrays[indexPath.row] as! NSArray
        let cell = itemInfoTableViewCell.init(iconImageName: cellParamsArray[1] as! String ,
                                                name: cellParamsArray[0] as! String,
                                                type: cellParamsArray[2] as! addNewItemTableViewCellType,
                                                style: UITableViewCell.CellStyle.default,
                                                reuserIdentifier: todoItemInfoView.tableViewCellIdentifier)
        if(cellParamsArray[2] as! addNewItemTableViewCellType == .cellTypeTextField) {
            cell.textFieldDefaultText = "在此输入事件名"
        }
        if(cellParamsArray[0] as! String == "Date") {
            weak var weakSelf = self
            cell.didClickCellBlk = {
                weakSelf!._handleClickDatePick(cell: cell, indexPath: indexPath)
            }
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
        return Date.init()
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
        let dateformatter = DateFormatter.init()
        
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        if cell.detailTextField.text == "" {
            datePicker.date = .now
        }
        else {
            datePicker.date = dateformatter.date(from: cell.detailTextField.text!) ?? .now
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

            cell.detailTextField.text = dateformatter.string(from: datePicker.date)
        })
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        
        alertVC.addAction(confirmAction)
        alertVC.addAction(cancelAction)
        
        self._getViewController()?.present(alertVC, animated: true, completion: nil)
    }
}
