//
//  uiTableViewTest2.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/30.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

class uiTableViewTest2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var myTableView: UITableView!
    
    struct ListNode {
        var index:Int = 0
        var level:Int  = 1
        var value: String = ""
        var display:Bool = false
    }
    var cellList = [ListNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellList.append(ListNode(index:0, level:1,  value:"data 1",     display:true))
        cellList.append(ListNode(index:1, level:2,  value:"data 1-1",   display:false))
        cellList.append(ListNode(index:2,level:2,   value:"data 1-2",   display:false))
        cellList.append(ListNode(index:3,level:1,   value:"data 2",     display:true))
        cellList.append(ListNode(index:4,level:2,   value:"data 2-1",   display:false))
        cellList.append(ListNode(index:5,level:3,   value:"data 2-1-1", display:false))
        cellList.append(ListNode(index:6,level:3,   value:"data 2-1-2", display:false))
        cellList.append(ListNode(index:7,level:2,   value:"data 2-2",   display:false))
        cellList.append(ListNode(index:8,level:1,   value:"data 3",     display:true))
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-100))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ip = cellList.filter { (n) -> Bool in n.display }[indexPath.row].index
        if cellList.count <= ip+1 { return }
        let lev = cellList[ip].level + 1
        if cellList[ip+1].display == false {
            let ipEnd = cellList.filter { (n) -> Bool in n.display }[indexPath.row+1].index
            cellList.filter{ (n) -> Bool in n.index > ip && n.index <= ipEnd && n.level == lev }.forEach {  cellList[$0.index].display = true }
        } else {
            let ipEnd = cellList.filter{ (n) -> Bool in n.index > ip }.first { $0.level < lev }?.index
            cellList.filter{ (n) -> Bool in n.index > ip && n.index < ipEnd! && n.level >= lev }.forEach {  cellList[$0.index].display = false }
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellList.filter { (n) -> Bool in n.display }.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        let nList = cellList.filter { (n) -> Bool in n.display }
        cell.textLabel!.text = nList[indexPath.row].value
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/*
 let _ = cellList.reduce(0, { (count,n) -> Int in
 cellList[count].index = count
 return count + 1
 })
 */

