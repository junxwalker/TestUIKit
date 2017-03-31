//
//  ViewController.swift
//  testUIKit
//
//  Created by jun walker on 2017/2/15.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        /*
        let vcMain = uiCollectionViewTest()
        vcMain.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 82)
        vcMain.initViewFor(storyboard: ["ab1","ab2","ab3","ab4","ab1","ab2","ab3","ab4"], iTemWidth: 200, iTemHeight: 50)
        self.addChildViewController(vcMain)
        self.view.addSubview(vcMain.view)

        let vcClient = uiCollectionViewTest()
        vcClient.view.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100)
        vcClient.initViewFor(storyboard: ["VC1","VC2","VC3","VC4","VC1","VC2","VC3","VC4"], iTemWidth: Double(UIScreen.main.bounds.width), iTemHeight: Double(UIScreen.main.bounds.height-100))
        self.addChildViewController(vcClient)
        self.view.addSubview(vcClient.view)
        
        vcMain.delegate = vcClient
        vcClient.delegate = vcMain
        */
        
        let vc = uiScrollViewTest()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)


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



