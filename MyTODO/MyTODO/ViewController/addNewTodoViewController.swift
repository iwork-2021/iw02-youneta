//
//  addNewTodoViewController.swift
//  MyTODO
//
//  Created by nju on 2021/10/19.
//

import UIKit

typealias completionBlk = (TodoItemModel) -> ()

class addNewTodoViewController: UIViewController {
    
    private lazy var model:TodoItemModel = TodoItemModel()
    private lazy var _addNewTodoView:todoItemInfoView = todoItemInfoView.init()
    var completeBlk: completionBlk? = nil

    
    //MARK: init
    
    init(model: TodoItemModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        self._addNewTodoView = todoItemInfoView.init(name: self.model.itemName ?? "", date: self.model.date ?? Date.now, checked: self.model.check ?? false, description: self.model.itemDescription ?? "")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupCompleteBtn()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self._setupUI()
    }
    
    
    //MARK: setupUI
    
    private func _setupUI() {
        self.view.addSubview(self._addNewTodoView)
        self._setupConstraints()
    }
    
    private func _setupConstraints() {
        self._addNewTodoView.backgroundColor = UIColor.yellow
        self._addNewTodoView.autoresizesSubviews = false
        self._addNewTodoView.translatesAutoresizingMaskIntoConstraints = false
        self._addNewTodoView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self._addNewTodoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self._addNewTodoView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self._addNewTodoView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    //MARK: private methods
    private func _setupCompleteBtn() {
        let completeBtn = UIButton.init(type: UIButton.ButtonType.custom)
        completeBtn.setTitle("Comlete", for: UIControl.State.normal)
        completeBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        completeBtn.addTarget(self, action: #selector(_handleCompleteAdd), for:UIControl.Event.touchUpInside);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: completeBtn)
        self.view.backgroundColor = UIColor.black
    }
    
    @objc func _handleCompleteAdd(sender: UIBarButtonItem) {
        self.model.check = self._addNewTodoView.getIsCheck()
        self.model.date = self._addNewTodoView.getDate()
        self.model.itemDescription = self._addNewTodoView.getDecription()
        self.model.itemName = self._addNewTodoView.getNameText()
        //注意闭包判空
        if(self.completeBlk == nil) {
        }
        else {
            self.completeBlk!(self.model)
        }
        self.navigationController?.popViewController(animated: true)

    }
}
