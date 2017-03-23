//
//  uiTableViewTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/21.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

class uiTableViewTest: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Tableで使用する配列を設定する
    private let myItems: NSArray = ["TEST1", "TEST2", "TEST3", "TEST4","TEST5","TEST6","TEST7","TEST8","TEST9"]
    private var myTableView: UITableView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成(Status barの高さをずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight+200, width: displayWidth, height: 100))
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceを自身に設定する.
        myTableView.dataSource = self
        
        // Delegateを自身に設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
        
        
        
        let changeIconBtn = UIButton()
        changeIconBtn.frame = CGRect(x: 10, y: 100, width: 100, height: 50)
        changeIconBtn.backgroundColor = UIColor.yellow
        changeIconBtn.titleLabel?.text = "Change!"
        changeIconBtn.addTarget(self, action: #selector(uiTableViewTest.changeImage), for: .touchUpInside)
        self.view.addSubview(changeIconBtn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func changeImage() {
        print("change Image")
        print("aa", aa)
        //let updateImage = myTableView.cellForRow(at: IndexPath(row: 5, section: 0))
        //updateImage?.imageView?.image = UIImage(named: "00005")
        
        for n in om {
            print(n, "---", n.oimage)
        }
        
    }
    
    
    
    
    /*
     Cellが選択された際に呼び出される
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myItems[indexPath.row])")

    }
    
    /*
     Cellの総数を返す.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    var oldImage:[UIImage?] = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    
    var aa:UIImage?
    
    
    
    class oimage {
        weak var oimage:UIImage?
        deinit {
            print("deinit")
        }
    }
    
    var om:[oimage] = [ oimage(),oimage(),oimage(),oimage(),oimage(),oimage(),oimage(),oimage(),oimage(),oimage(),oimage(),oimage()]
    /*
     Cellに値を設定する
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        om[indexPath.row].oimage = UIImage(named: "00002")
        
        
        cell.imageView?.image = om[indexPath.row].oimage
        
        aa = cell.imageView?.image
        print("display index: ",indexPath.row)
        print("image n: ", cell.imageView?.image)

        print(indexPath.row, "---", om[indexPath.row].oimage)
        
        
        return cell
    }


    


}
