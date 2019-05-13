//
//  WJCollectionView.swift
//  CollectionViewFlowDemo
//
//  Created by william on 2019/3/11.
//  Copyright © 2019 4399. All rights reserved.
//

import UIKit

class WJCollectionView: UICollectionViewFlowLayout {
    
    var data : Array<CGFloat>?
    
    
    /** 每一列之间的间距 垂直 */
    private(set) var ColumnMargin : CGFloat = 10.0
    /** 每一行之间的间距 水平方向 */
    private(set) var ItemMargin : CGFloat = 10.0
    
    /** 边缘间距 */
    private(set) var EdgeInsetsDefault : UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    convenience init(data: Array<CGFloat>) {
        
        self.init()
        self.data = data
    }
    
    //懒加载
    //存放所有cell的布局属性
    lazy var attrsArray = [UICollectionViewLayoutAttributes]()
    //存放所有行的当前宽度
    lazy var rowWidthAry = [CGFloat]()
    
    //存放所有行的当前x坐标
    lazy var rowXAry = [CGFloat]()
    
    //存放所有行的当前y坐标
    lazy var rowYAry = [CGFloat]()
    
    // 缓存数组, 用于存储每行x的值的和
    var lineMaxValue: CGFloat = 0.0
    // 每行最大个数
    var tempMaxCount: Int = 0
    // 第几行
    var rowCount: Int = 0
    
    override func prepare() {
        super.prepare()
        
        // 清除宽度
        rowWidthAry.removeAll()
        
        //清除所有的布局属性
        attrsArray.removeAll()
        
        let count : Int = (self.collectionView?.numberOfItems(inSection: 0))!//获取分区0有多少个item
        for i in 0 ..< count {
            let indexpath : IndexPath = IndexPath.init(row: i, section: 0)
            rowWidthAry.append(self.data?[i] ?? 0)
            let attrs = self.layoutAttributesForItem(at: indexpath)!
            attrsArray.append(attrs)
        }
    }
    
    // 第二步 ：返回indexPath位置cell对应的布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let maxWidth: CGFloat = self.collectionView?.frame.width ?? 0.0
        //获得所有item的宽度
        let __W: CGFloat = self.rowWidthAry[indexPath.row]
        let __H: CGFloat = 40.0
        
        
        
        // 计算每个x,y存成数组
        if tempMaxCount==0 {
            lineMaxValue += ItemMargin
        }
        self.rowXAry.append(lineMaxValue)
        lineMaxValue += ItemMargin + __W
        tempMaxCount += 1
        
        self.rowYAry.append((CGFloat(rowCount)*(ColumnMargin + __H) + ColumnMargin))
        
        var lastItemLength: CGFloat = 0.0
        
        
        if (indexPath.row + 1) < ((self.data?.count)!) {
            lastItemLength = self.data![indexPath.row + 1] + ItemMargin
        }
        if lineMaxValue > (maxWidth - lastItemLength) {
            // 宽度不够放下一个item，重新一行
            tempMaxCount = 0
            lineMaxValue = 0.0
            rowCount += 1
        }
        
        let x = self.rowXAry[indexPath.row]
        let y = self.rowYAry[indexPath.row]
        attrs.frame = CGRect(x: x, y: y, width: __W, height: CGFloat(__H))
        //更新最短那列高度
        rowWidthAry[indexPath.row] = attrs.frame.maxY
        print("frame\(attrs.frame)")
//        print("x: \(self.rowXAry)")
//        print("y: \(self.rowYAry)")
        return attrs
    }
    
    //第三步 ：重写  返回所有行的宽
    override var collectionViewContentSize: CGSize{
        
        return CGSize.init(width: 0, height: (self.collectionView?.frame.height)!)
    }
    
    //第四步 ：返回collection的item的frame
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attrsArray
    }
    
}
