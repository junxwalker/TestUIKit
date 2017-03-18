//
//  uiCollectionViewTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/17.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import Foundation
//
//  ViewController.swift
//  UIKit053_3.0
//
//  Created by KimikoWatanabe on 2016/08/21.
//  Copyright © 2016年 FaBo, Inc. All rights reserved.
//

import UIKit

class uiCollectionViewTest: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var myCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立 UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        
        // 設置每個 cell 的尺寸
        layout.itemSize = CGSize(width:50, height:50)
        
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 32, 16)
        
        // 設置 header 的尺寸
        layout.headerReferenceSize = CGSize(width:100,height:30)
        
        // 建立 UICollectionView
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        // 註冊 cell 以供後續重複使用
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        // 設置委任對象
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        self.view.addSubview(myCollectionView)
        
    }
    
    /*
     點擊 CELL
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        print("Value:\(collectionView)")
        
    }
    
    /*
     回傳 section 區段 的 cell 數目
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    /*
     Cell 內容設定
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell",
                                                                             for: indexPath as IndexPath)
        
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
}


