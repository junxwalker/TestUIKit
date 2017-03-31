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






class uiCollectionViewTest: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var myCollectionView : UICollectionView!
    var iTemVC = [UIViewController]()
    var delegate:uiCollectionViewTest?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initViewFor(storyboard sbd:[String], iTemWidth width:Double, iTemHeight height:Double) {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:width, height:height)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.scrollDirection = .horizontal
        let fr = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        myCollectionView = UICollectionView(frame: fr, collectionViewLayout: layout)
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.isPagingEnabled = true
        
        self.view.addSubview(myCollectionView)
        
        sbd.map { (sdbName) in
            addItemFor(storyboard: sdbName, iTemWidth: width, iTemHeight: height)
        }
    }
    
    func addItemFor(storyboard sbd:String, iTemWidth width:Double, iTemHeight height:Double) {
        let item:UIViewController = UIStoryboard(name: sbd, bundle: nil).instantiateViewController(withIdentifier: sbd)
        item.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        iTemVC.append(item)
        self.addChildViewController(item)
    }
    
    func doSomeThing() {
        print("doSomeThing --- ", self.description)
        //myCollectionView.setContentOffset(<#T##contentOffset: CGPoint##CGPoint#>, animated: <#T##Bool#>)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        print("svds: ",self.description, point)
        self.delegate?.doSomeThing()
        //self.delegate?.myCollectionView.setContentOffset(point, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (iTemVC.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.addSubview((iTemVC[indexPath.row].view)!)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        print("Value:\(collectionView)")
    }
    
}





