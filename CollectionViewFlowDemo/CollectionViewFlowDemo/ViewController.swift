//
//  ViewController.swift
//  CollectionViewFlowDemo
//
//  Created by william on 2019/3/11.
//  Copyright © 2019 4399. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellID : String = "cellID"
    
    var collectionView : UICollectionView?
    
    
    var list = ["王者荣耀", "非人学园", "忍者必须死3", "黑洞大作战", "非人学园黑洞大作战", "王者荣耀", "忍者必须死3", "非人学园", "忍者必须死3", "黑洞大作战", "非人学园黑洞大作战", "非人学园", "忍者必须死3", "黑洞大作战", "非人黑洞大作战", "非人学园", "忍者必须死3", "黑洞大作战", "非人学园黑洞大作战"]
    
    func widthList() -> Array<CGFloat> {
        var tempAry : Array<CGFloat> = []
        for item in self.list {
            let item: String = item
            let length = item.calculateStringLengthWithFontSize(fontSize: 16) + 2*10
            tempAry.append(length)
        }
        return tempAry
    }
    
    func randomArray(_ list: Array<Any>) -> Array<Any> {
        var temList = list
        
        temList.enumerated().map{(index, ele) in
            let i = arc4random_uniform(UInt32(temList.count - 1 > 0 ? temList.count - 1:0))
            temList.swapAt(Int(i), index)
        }
        
        return temList
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: UIScreen.main.bounds.size.width*0.5 - 80*0.5, y: UIApplication.shared.statusBarFrame.height, width: 80, height: 40)
        button.backgroundColor = UIColor.blue
        button.setTitle("刷新", for: .normal)
        button.addTarget(self, action: #selector(refresh), for: .touchDown)
        self.view.addSubview(button)
        
        //布局
        let layout = WJCollectionView(data: widthList())
        
//        let layout = UICollectionViewFlowLayout()
        
        //创建collectionView
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 40, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.yellow
        
        collectionView.register(WJCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
    }


    @objc func refresh() {
        list = self.randomArray(list) as? Array<String> ?? list
        let layout = WJCollectionView(data: widthList())
        collectionView?.reloadData()
        collectionView?.setCollectionViewLayout(layout, animated: false)
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WJCollectionViewCell
        
        cell.configCell(title: list[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}

