//
//  uiPresentationControllerTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/24.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

class uiPresentationControllerTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        
        let bt = UIButton()
        bt.frame = CGRect(x: 10, y: 50, width: 200, height: 60)
        bt.backgroundColor = UIColor.blue
        bt.setTitle("Button!", for: .normal)
        self.view.addSubview(bt)
        
        let pcvc = presentationControllerVC()
        pcvc.modalPresentationStyle = UIModalPresentationStyle
        
        let popPC
        UIPopoverPresentationController popPC = pcvc.popoverPresentationController
        popPC.
        
        self.view.addSubview(pcvc.view)
        self.addChildViewController(pcvc)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



class presentationControllerVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRect(x: 100, y: 200, width: 180, height: 200)
        self.view.backgroundColor = UIColor.red
        
        let bt = UIButton()
        bt.frame = CGRect(x: 10, y: 50, width: 100, height: 60)
        bt.backgroundColor = UIColor.green
        bt.setTitle("OK!", for: .normal)
        self.view.addSubview(bt)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
