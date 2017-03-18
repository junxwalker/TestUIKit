//
//  nsUserDefaultsTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/14.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import Foundation
import UIKit


class nsUserDefaultsTest: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    let aa = ["13":13,"23":23, "34":34]

    
    
    
}


class jxNSUserDefaults {
    
    
    
    func setDictionaryData(_ key:String, datais data:Dictionary<String, Any>) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getDictionaryData() -> Dictionary<String, Any>? {
        if let dictionary = UserDefaults.standard.object(forKey: "NSDictionary") as? Dictionary<String, Any> {
            return dictionary
        } else {
            print("getKeyAndDataDictionary ERROR! [no key]!")
            return nil
        }
    }

    func setStringData(_ key:String, datais data:String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    

    func getStringKey(_ key:String) -> String? {
        //return UserDefaults.standard.object(forKey: key) as? String
        if let info = UserDefaults.standard.object(forKey: key) as? String {
            return info
        } else {
            print("getDatainKey ERROR! [no key]!")
            return nil
        }
    }
    

    func deleteDatainKey(_ key:String)  {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    
    /**
     判断APP是否第一次运行, 需要自己设定已使用标签, 使用setFirstRunMark()
     
     - parameter nil
     
     - returns:  (Bool)  true->首次运行(未设定过标签)
     */
    func checkFirstRun() -> Bool {
        if (UserDefaults.standard.object(forKey: "firstRunApp") as? Bool) != nil {
            return false
        } else {
            return true
        }
    }
    
    
    /**
     设定FirstRunMark Key, 代表APP已经运行过.
     
     - parameter nil
     
     - returns:  nil
     */
    func setFirstRunMark()  {
        UserDefaults.standard.set(true, forKey:"firstRunApp")
        UserDefaults.standard.synchronize()
    }
    
    /**
     删除APP首次运行 FirstRunMark Key.
     
     - parameter nil
     
     - returns:  nil
     */
    func appReturnToFirstRun() {
        UserDefaults.standard.removeObject(forKey: "firstRunApp")
        UserDefaults.standard.synchronize()
    }
}



