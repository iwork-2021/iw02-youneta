//
//  addNewItemTableViewCell.swift
//  MyTODO
//
//  Created by nju on 2021/10/19.
//

import UIKit

enum addNewItemTableViewCellType {
    case cellTypeDefault
    case cellTypeSwitch
    case cellTypeTextField
    case cellTypeMoreAction
}

typealias voidBlk = () -> ()

class itemInfoTableViewCell: UITableViewCell {
    static let moreActionImageName : String = "moreAction"
    
    //MARK: properties
    var didClickCellBlk : voidBlk?
    var textFieldDefaultText : String? {
        didSet {
            if(self.cellType == addNewItemTableViewCellType.cellTypeTextField){
                self.detailTextField.placeholder = textFieldDefaultText
            }
        }
    }
    lazy var iconImageView : UIImageView = {
        var imageView = UIImageView.init()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    lazy var nameLabel : UILabel = UILabel()
    lazy var detailTextField : UITextField = {
        var textField = UITextField()
        return textField
    }()
    lazy var switchButton : UISwitch = UISwitch()
    lazy var moreActionImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage.init(named: itemInfoTableViewCell.moreActionImageName)
        return imageView
    }()
    

    
    
    private var cellType: addNewItemTableViewCellType = .cellTypeTextField
    
    //MARK: init
    
    init(iconImageName: String, name: String, type: addNewItemTableViewCellType, style: UITableViewCell.CellStyle, reuserIdentifier: String){
        super.init(style: style, reuseIdentifier: reuserIdentifier)
        self.nameLabel.text = name
        self.detailTextField.text = ""
        self.iconImageView.image = UIImage.init(named: iconImageName)
        self.cellType = type
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.nameLabel)
        self.addSubview(self.iconImageView)
        switch self.cellType {
        case .cellTypeDefault:
            break
        case .cellTypeTextField:
            self.addSubview(self.detailTextField)
            break
        case .cellTypeSwitch:
            self.addSubview(self.switchButton)
            break
        case .cellTypeMoreAction:
            self.addSubview(self.moreActionImageView)
            self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(_handleTapGes)))
            self.addSubview(self.detailTextField)
            self.detailTextField.isEnabled = false
            break
        }
        self._setupUI()
    }
    
    @objc func _handleTapGes(sender: UITapGestureRecognizer) {
        self.didClickCellBlk!()
    }
    
    //MARK: setupUI
    private func _setupUI() {
//        let itemSize = CGSize(width: 15, height: 15)
//        UIGraphicsBeginImageContext(itemSize)
//        let itemRect = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
//        self.iconImageView.image?.draw(in: itemRect)
//        self.iconImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        self._setupContraints()
    }
    
    private func _setupContraints() {
        self.iconImageView.autoresizesSubviews = false
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.iconImageView.widthAnchor.constraint(equalTo: self.iconImageView.heightAnchor).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        self.nameLabel.autoresizesSubviews = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.leftAnchor.constraint(equalTo: self.iconImageView.rightAnchor, constant: 10).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        switch self.cellType {
        case .cellTypeDefault:
            break
        case .cellTypeTextField:
            self.detailTextField.autoresizesSubviews = false
            self.detailTextField.translatesAutoresizingMaskIntoConstraints = false
            self.detailTextField.leftAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
            self.detailTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.detailTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.detailTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
            break
        case .cellTypeSwitch:
            self.switchButton.autoresizesSubviews = false
            self.switchButton.translatesAutoresizingMaskIntoConstraints = false
            self.switchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -1).isActive = true
            self.switchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            break
        case .cellTypeMoreAction:
            self.moreActionImageView.autoresizesSubviews = false
            self.moreActionImageView.translatesAutoresizingMaskIntoConstraints = false
            self.moreActionImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.moreActionImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
            self.moreActionImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            self.moreActionImageView.widthAnchor.constraint(equalTo: self.moreActionImageView.heightAnchor).isActive = true
            
            self.detailTextField.autoresizesSubviews = false
            self.detailTextField.translatesAutoresizingMaskIntoConstraints = false
            self.detailTextField.leftAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
            self.detailTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.detailTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.detailTextField.rightAnchor.constraint(equalTo: self.moreActionImageView.leftAnchor).isActive = true
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
