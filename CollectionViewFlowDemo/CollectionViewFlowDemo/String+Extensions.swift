//
//  String+Extensions.swift
//  CollectionViewFlowDemo
//
//  Created by william on 2019/3/11.
//  Copyright © 2019 4399. All rights reserved.
//

import UIKit

extension String {
    // MARK: 根据字体大小计算字符串长度
    func calculateStringLengthWithFontSize(fontSize: CGFloat) -> CGFloat {
        
        let textSize = CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat(MAXFLOAT))
        
        let stringWidth = self.boundingRect(with: textSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.width
        
        return stringWidth
    }
}
