//
//  TableViewCell.swift
//  MyTODO
//
//  Created by nju on 2021/10/15.
//

import UIKit
typealias tapInfoBlk = (todoItemsTableViewCell) -> ()

class todoItemsTableViewCell: UITableViewCell {

    lazy var nameLabel : UILabel = UILabel()
    lazy var circleImageView : UIImageView = UIImageView()
    lazy var correctImageView : UIImageView = UIImageView()
    lazy var infoImageView : UIImageView = UIImageView()
    var didTapInfoBlk : tapInfoBlk? = nil
    
    //MARK: initializer
    init(name: String, check: Bool, style: UITableViewCell.CellStyle, reuserIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuserIdentifier)
        self.nameLabel.text = name
        self.correctImageView.isHidden = !check
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.nameLabel)
        self.addSubview(self.circleImageView)
        self.addSubview(self.correctImageView)
        self.addSubview(self.infoImageView)
        self._setupUI()
    }
    
    private func _setupUI() {
        self._setupConstraints()
        self.circleImageView.image = UIImage.init(named: "circle")
        self.correctImageView.image = UIImage.init(named: "correct")
        self.infoImageView.image = UIImage.init(named: "info")
        
        if !self.correctImageView.isHidden {
            self.setLabelDelLine()
        }
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(_handleTapInfo))
        self.infoImageView.addGestureRecognizer(tapGes)
        self.infoImageView.isUserInteractionEnabled = true
    }
    
    private func _setupConstraints() {
        self.circleImageView.autoresizesSubviews = false
        self.circleImageView.translatesAutoresizingMaskIntoConstraints = false
        self.circleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.circleImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        self.circleImageView.widthAnchor.constraint(equalTo: self.circleImageView.heightAnchor).isActive = true
        self.circleImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        self.correctImageView.autoresizesSubviews = false
        self.correctImageView.translatesAutoresizingMaskIntoConstraints = false
        self.correctImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.correctImageView.widthAnchor.constraint(equalTo: self.circleImageView.widthAnchor).isActive = true
        self.correctImageView.topAnchor.constraint(equalTo: self.circleImageView.topAnchor).isActive = true
        self.correctImageView.bottomAnchor.constraint(equalTo: self.circleImageView.bottomAnchor).isActive = true
        
        self.infoImageView.autoresizesSubviews = false
        self.infoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.infoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.infoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.infoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        self.infoImageView.widthAnchor.constraint(equalTo: self.infoImageView.heightAnchor).isActive = true
        
        self.nameLabel.autoresizesSubviews = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.leftAnchor.constraint(equalTo: self.circleImageView.rightAnchor, constant: 10).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.infoImageView.leftAnchor, constant: -10).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    //MARK: private methods
    
    @objc func _handleTapInfo(sender: UIGestureRecognizer) {
        if(self.didTapInfoBlk != nil) {
            self.didTapInfoBlk!(self)
        }
    }

    
    //MARK: public methods
    func setLabelDelLine() {
        self.nameLabel.attributedText = NSAttributedString.init(string: self.nameLabel.text ?? "", attributes: [.strikethroughStyle:1])
    }
    
    func removeLabelDelLine() {
        self.nameLabel.attributedText = NSAttributedString.init(string: self.nameLabel.text ?? "")
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
