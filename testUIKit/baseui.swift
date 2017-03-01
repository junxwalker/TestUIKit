//
//  baseui.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/1.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit



class baseui: UIViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let upView:UIView = {
            $0.backgroundColor = UIColor.red
            $0.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:200)
            //           $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        } (UIView())
        self.view.addSubview(upView)
        
        let barView:UIView = {
            $0.backgroundColor = UIColor.blue
            $0.frame = CGRect(x: 0, y: 200, width:UIScreen.main.bounds.width, height:50)
            //            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        } (UIView())
        self.view.addSubview(barView)
        
        let downView:UIView = {
            $0.backgroundColor = UIColor.yellow
            $0.frame = CGRect(x: 0, y: 250, width:UIScreen.main.bounds.width, height:200)
            //            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        } (UIView())
        self.view.addSubview(downView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
