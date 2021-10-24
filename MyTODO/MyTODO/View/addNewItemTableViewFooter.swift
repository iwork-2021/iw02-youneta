//
//  addNewItemTableViewFooter.swift
//  MyTODO
//
//  Created by nju on 2021/10/22.
//

import UIKit

class addNewItemTableViewFooter: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    lazy var descriptionTextView : UITextView = UITextView()
    lazy var defaultText : String = ""
    
    //MARK: init
    init(defaultText: String, resuerIdetifier: String) {
        super.init(reuseIdentifier: resuerIdetifier)
        self.descriptionTextView.text = defaultText
        self.defaultText = defaultText
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.descriptionTextView)
        self._setupUI()
    }
    
    //MARK: setupUI
    func _setupUI() {
        self._setupConstraits()
        self.descriptionTextView.backgroundColor = UIColor.darkGray
        self.descriptionTextView.textAlignment = .left
        self.descriptionTextView.layer.cornerRadius = 10.0
        self.descriptionTextView.layer.masksToBounds = true
    }
    
    func _setupConstraits() {
        self.descriptionTextView.autoresizesSubviews = false
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionTextView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.descriptionTextView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.descriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
