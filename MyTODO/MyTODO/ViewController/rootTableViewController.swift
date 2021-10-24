//
//  rootTableViewController.swift
//  MyTODO
//
//  Created by nju on 2021/10/15.
//


import UIKit


class rootTableViewController : UITableViewController {
    static var cellIdentifier : String = "todoItem"
    private var cellModelArray = NSMutableArray.init()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.title = "TODO List"
        self.tableView.register(todoItemsTableViewCell.self, forCellReuseIdentifier: rootTableViewController.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupTableView()
        self._setupAddNewBtn()
    }

    //MARK: private methods
    private func _setupAddNewBtn() {
        let addTodoBtn = UIButton.init(type: UIButton.ButtonType.custom)
        addTodoBtn.setTitle("Add", for: UIControl.State.normal)
        addTodoBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addTodoBtn.addTarget(self, action: #selector(_handleClickAddTodoItem), for:UIControl.Event.touchUpInside);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addTodoBtn)
        self.view.backgroundColor = UIColor.black
    }
    
    @objc func _handleClickAddTodoItem(sender: UIBarButtonItem) {
        let addNewVC = addNewTodoViewController.init()
        weak var weakSelf = self
        addNewVC.completeBlk = {(model:TodoItemModel) -> () in
            if model.itemName != ""{
                weakSelf?._handleCompleteAddTodoItem(model: model)
            }
        }
        self.navigationController?.pushViewController(addNewVC, animated: true)
        
    }
    
    private func _handleCompleteAddTodoItem(model: TodoItemModel) {
        let _indexPath = IndexPath.init(row: self.tableView.numberOfRows(inSection: 0), section: 0)
        cellModelArray.insert(model, at: _indexPath.row)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [_indexPath], with: UITableView.RowAnimation.left)
        self.tableView.endUpdates()
        self.tableView.reloadData()
    }
    
    private func _setupTableView() {

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cellModelArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: TodoItemModel = cellModelArray[indexPath.row] as! TodoItemModel
        let cell = todoItemsTableViewCell.init(name: model.itemName!, check: model.check ?? false, style: .default, reuserIdentifier: rootTableViewController.cellIdentifier)
        weak var weakSelf = self
        cell.didTapInfoBlk = { (cell: todoItemsTableViewCell) -> () in
            weakSelf?._showInfoForCell(cell: cell)
        }
        cell.selectionStyle = .none
        return cell
    }

    // MARK: table view delegeate
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.darkGray
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        self.tableView.setEditing(true, animated: true)
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.cellModelArray.removeObject(at: indexPath.row)
        self.tableView.reloadData()
//        self.tableView.setEditing(false, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {

    }
    
    // MARK: private methods
    private func _showInfoForCell(cell: todoItemsTableViewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
    }
}



