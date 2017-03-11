//
//  caLayer_Test.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/6.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit


class caLayer_Test: UIViewController {
    
    
    let blueLayer = CALayer()
    let redLayer = CALayer()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let baseView:UIView = {
            $0.frame = CGRect(x: 0, y: 000, width: UIScreen.main.bounds.width, height: 200)
            $0.backgroundColor = UIColor.gray
            return $0
        } (UIView())
        self.view.addSubview(baseView)
        
        blueLayer.frame = CGRect(x: 50.0, y: 50.0, width: 100.0, height: 100.0)//.insetBy( dx: 10,dy: 10)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        blueLayer.opacity = 0.9
        blueLayer.cornerRadius = 10
        baseView.layer.addSublayer(blueLayer)
        

        redLayer.frame = CGRect(x: 50.0, y: 350.0, width: 100.0, height: 100.0)
        redLayer.backgroundColor = UIColor.red.cgColor
        redLayer.cornerRadius = 10
        redLayer.opacity = 0.9
        self.view.layer.addSublayer(redLayer)
        
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(caLayer.btnAction), for: .touchDown)
        self.view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnAction() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.25)
        if blueLayer.frame.height == 100 {
            blueLayer.frame = CGRect(x: 50, y: 350.0, width: 200, height: 200)
            redLayer.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        } else {
            blueLayer.frame = CGRect(x: 50.0, y: 50.0, width: 100.0, height: 100.0)
            redLayer.frame = CGRect(x: 50.0, y: 350.0, width: 100.0, height: 100.0)
            
        }
        CATransaction.commit()
    }
}


