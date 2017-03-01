//
//  ViewController.swift
//  testUIKit
//
//  Created by jun walker on 2017/2/15.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let blueLayer = CALayer()
    let uiview = UIView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let vc = avPlayer()
        self.view.addSubview(vc.view)
        self.addChildViewController(vc)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //let vc = avPlayer()
        //self.present(vc, animated:true, completion:nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

