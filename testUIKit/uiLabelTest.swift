//
//  uiLabelTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/23.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

class uiLabelTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        let la = strokeColor()
        la.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        la.text = "Color123"
        self.view.addSubview(la)
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}



@IBDesignable class strokeColor: UILabel {
    @IBInspectable open var strokeColor: UIColor = UIColor.white {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable open var strokeWidth: CGFloat = 2 {
        didSet { setNeedsDisplay() }
    }
    
    override func drawText(in rect: CGRect) {
        let textColor = self.textColor
        
        let c = UIGraphicsGetCurrentContext()!
        c.setLineWidth(strokeWidth)
        c.setLineJoin(.round)
        
        c.setTextDrawingMode(.stroke)
        self.textColor = strokeColor
        super.drawText(in: rect)
        
        c.setTextDrawingMode(.fill)
        self.textColor = textColor
        super.drawText(in: rect)
    }
}



