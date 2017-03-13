//
//  dateTimeTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/13.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import Foundation

import UIKit



class dateTimeTest: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //获取当前时间
        let now = NSDate()
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let ndstr = dformatter.string(from: now as Date)
        print("当前日期时间：\(ndstr)")
        
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        
        //计算指定月天数
        let days = daysCount(year: 2016,month: 2)
        print("2016年2月有\(days)天")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //计算指定月天数
    func daysCount(year: Int, month: Int) -> Int {
        
        var daysArray = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if year % 400 == 0 || year % 100 != 0 && year % 4 == 0 {
            daysArray[2] += 1
        }
        return daysArray[month]
    }
    
}


