//
//  addNewTodoView.swift
//  MyTODO
//
//  Created by nju on 2021/10/19.
//

import UIKit

class addNewTodoView: UIView, UITableViewDelegate, UITableViewDataSource {

    //MARK: static
    static var tableViewCellIdentifier : String = NSStringFromClass(addNewItemTableViewCell.self)
    static var tableViewFooterIdentifier : String = NSStringFromClass(addNewItemTableViewFooter.self)
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
    
    lazy var itemDetailTableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.itemDetailTableView)
        self._setupUI()
    }
    
    //MARK: setupUI
    func _setupUI() {
        self.itemDetailTableView.register(addNewItemTableViewCell.self, forCellReuseIdentifier: addNewTodoView.tableViewCellIdentifier)
        self.itemDetailTableView.register(addNewItemTableViewFooter.self, forHeaderFooterViewReuseIdentifier: addNewTodoView.tableViewFooterIdentifier)
        self.itemDetailTableView.delegate = self;
        self.itemDetailTableView.dataSource = self;

        self._setupConstraints()
        
    }
    
    func _setupConstraints() {
        self.itemDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        self.itemDetailTableView.autoresizesSubviews = false
        
        let tableViewTopConstraint = NSLayoutConstraint.init(item: self.itemDetailTableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0);
        tableViewTopConstraint.isActive = true
        
        let tableViewLeftConstraint = NSLayoutConstraint.init(item: self.itemDetailTableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0);
        tableViewLeftConstraint.isActive = true
        
        let tableViewRightConstraint = NSLayoutConstraint.init(item: self.itemDetailTableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        tableViewRightConstraint.isActive = true
        
        let tableViewBottomConstraint = NSLayoutConstraint.init(item: self.itemDetailTableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 2, constant: 0)
        tableViewBottomConstraint.isActive = true
    }
    
    //MARK: tableview delegate
    
    
    
    //MARK: tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addNewTodoView.cellParamsArrays.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellParamsArray : NSArray = addNewTodoView.cellParamsArrays[indexPath.row] as! NSArray
        let cell = addNewItemTableViewCell.init(iconImageName: cellParamsArray[1] as! String ,
                                                name: cellParamsArray[0] as! String,
                                                type: cellParamsArray[2] as! addNewItemTableViewCellType,
                                                style: UITableViewCell.CellStyle.default,
                                                reuserIdentifier: addNewTodoView.tableViewCellIdentifier)
        if(cellParamsArray[2] as! addNewItemTableViewCellType == .cellTypeTextField) {
            cell.textFieldDefaultText = "在此输入事件名"
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = addNewItemTableViewFooter.init(defaultText: addNewTodoView.footerDefaultText,
                                                    resuerIdetifier: addNewTodoView.tableViewFooterIdentifier)
        return footer
    }
    
    //MARK: public methods
    func getNameText() -> String {
        let _indexPath = IndexPath.init(row: 0, section: 0)
        let nameCell : addNewItemTableViewCell = self.itemDetailTableView.cellForRow(at: _indexPath) as! addNewItemTableViewCell
        return nameCell.detailTextField.text!
    }
    
    func getIsCheck() -> Bool {
        let _indexPath = IndexPath.init(row: 2, section: 0)
        let checkCell : addNewItemTableViewCell = self.itemDetailTableView.cellForRow(at: _indexPath) as! addNewItemTableViewCell
        return checkCell.switchButton.isOn
    }
    
    func getDate() -> Date {
        return Date.init()
    }
    
    func getDecription() -> String {
        let footer : addNewItemTableViewFooter = self.itemDetailTableView.footerView(forSection: 0) as! addNewItemTableViewFooter
        return footer.descriptionTextView.text!
    }
}
