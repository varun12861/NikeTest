//
//  HomeTableViewCell.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var albumImageView:UIImageView = UIImageView()
    var nameLbl:UILabel = UILabel()
    var titleLbl:UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    func configureUI() {
        
        self.contentView.addSubview(albumImageView)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(titleLbl)

        nameLbl.numberOfLines = 0
        titleLbl.numberOfLines = 0
        albumImageView.backgroundColor = UIColor.yellow

        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        UIView.setConstraints(for:albumImageView, toParent: self.contentView, leading:20.0, height:100.0, width:100.0,hasTrailing:false, hasTop:false, hasBottom:false, hasCenterY:true)

        
        titleLbl.leadingAnchor.constraint(equalTo:self.albumImageView.trailingAnchor, constant:20.0).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:10.0).isActive = true
        titleLbl.topAnchor.constraint(equalTo:self.albumImageView.topAnchor, constant:0.0).isActive = true
        
        titleLbl.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        
        nameLbl.leadingAnchor.constraint(equalTo:self.albumImageView.trailingAnchor, constant:20.0).isActive = true
        nameLbl.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:10.0).isActive = true
        nameLbl.topAnchor.constraint(equalTo:self.titleLbl.bottomAnchor, constant:10.0).isActive = true
        
        nameLbl.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        
    }

}
