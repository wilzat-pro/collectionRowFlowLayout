//
//  WJCollectionViewCell.swift
//  CollectionViewFlowDemo
//
//  Created by william on 2019/3/11.
//  Copyright © 2019 4399. All rights reserved.
//

import UIKit

class WJCollectionViewCell: UICollectionViewCell {
    
    var midTextLabel : UILabel!
    
    let margin: CGFloat = 10.0
    
    let itemHeight: CGFloat = 40.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        midTextLabel = UILabel()
        midTextLabel.font = UIFont.systemFont(ofSize: 16)
        midTextLabel.textAlignment = .center
        midTextLabel.textColor = UIColor.white
        
        self.contentView.backgroundColor = UIColor.lightGray

        self.contentView.addSubview(midTextLabel)
    }
    
    func configCell(title: String) {
        
        midTextLabel.text = title
        
        self.contentView.frame = CGRect(x: 0, y: 0, width: title.calculateStringLengthWithFontSize(fontSize: 16) + 2*margin, height: itemHeight)
        
        midTextLabel.frame = CGRect(x: margin, y: 0, width: title.calculateStringLengthWithFontSize(fontSize: 16), height: itemHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
