//
//  caLayer.swift
//  testUIKit
//
//  Created by jun walker on 2017/2/15.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

class caLayer: UIViewController {
    
    
    let blueLayer = CALayer()
    let uiview = UIView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        blueLayer.frame = CGRect(x: 50.0, y: 50.0, width: 100.0, height: 100.0)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(blueLayer)
        
        
        uiview.layer.frame = CGRect(x: 50.0, y: 550.0, width: 100.0, height: 100.0)
        uiview.layer.backgroundColor = UIColor.red.cgColor
        self.view.addSubview(uiview)
        
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
        CATransaction.setAnimationDuration(5)
        if blueLayer.frame.height == 100 {
            blueLayer.frame = CGRect(x: 50, y: 550, width: 200, height: 200)
            uiview.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        } else {
            blueLayer.frame = CGRect(x: 50.0, y: 50.0, width: 100.0, height: 100.0)
            uiview.layer.frame = CGRect(x: 50.0, y: 550.0, width: 100.0, height: 100.0)
            
        }
        CATransaction.commit()
    }
}


