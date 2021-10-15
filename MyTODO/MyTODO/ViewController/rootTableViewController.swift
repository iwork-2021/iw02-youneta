//
//  rootTableViewController.swift
//  MyTODO
//
//  Created by nju on 2021/10/15.
//


import UIKit


class rootTableViewController : UITableViewController {
    static var cellIdentifier : String = "todoItem"

    override init(style: UITableView.Style) {
        super.init(style: style)
        self.title = "TODO List"
        self.tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: rootTableViewController.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self._setupAddNewBtn()
    }

    //MARK: private methods
    func _setupAddNewBtn() {
        let addTodoBtn = UIButton.init(type: UIButton.ButtonType.custom)
        addTodoBtn.setTitle("Add", for: UIControl.State.normal)
        addTodoBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addTodoBtn.addTarget(self, action: #selector(_handleAddTodoItem), for:UIControl.Event.touchUpInside);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addTodoBtn)
        self.view.backgroundColor = UIColor.black
    }

    @objc func _handleAddTodoItem(sender: UIBarButtonItem) {
        let addNewVC = addNewTableViewController.init(style: UITableView.Style.plain)
        self.navigationController?.pushViewController(addNewVC, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rootTableViewController.cellIdentifier, for: indexPath)
        
        // Configure the cell...
        
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


