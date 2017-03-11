//
//  screenShot.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/3.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

extension UIView {
    func screenShot() -> UIImage? {
        guard frame.size.height > 0 && frame.size.width > 0 else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}


class screenShot: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let garView = UIView()
        garView.backgroundColor = UIColor.gray
        garView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        self.view.addSubview(garView)
        
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        redView.frame = CGRect(x: 0, y: 100, width: 30, height: 30)
        garView.addSubview(redView)
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        blueView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 30)
        garView.addSubview(blueView)
        
        
        
        let imageView = UIImageView(image: garView.screenShot())
        imageView.frame = CGRect(x: 0, y: 400, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/4)
        self.view.addSubview(imageView)
        
        redView.backgroundColor = UIColor.yellow
        blueView.backgroundColor = UIColor.yellow
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

