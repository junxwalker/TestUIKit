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
        
        
        
        let la = makeMark(200, 100, 20, 300, UIColor.yellow, 0)
        self.view.addSubview(la)
        let ta = makeLabel(0, 0, 80, 20, UIColor.black, "1")
        la.addSubview(ta)
        
        let lb = makeMark(200, 100, 20, 300, UIColor.blue, CGFloat((M_PI/6)*1))
        self.view.addSubview(lb)
        let tb = makeLabel(0, 0, 80, 20, UIColor.white, "2")
        //tb.transform = CGAffineTransform(rotationAngle: -1*CGFloat((M_PI/6)*1))
        lb.addSubview(tb)
        
        let lc = makeMark(200, 100, 20, 300, UIColor.red,  CGFloat((M_PI/6)*2))
        self.view.addSubview(lc)
        let tc = makeLabel(0, 0, 80, 20, UIColor.white, "3")
        //tc.transform = CGAffineTransform(rotationAngle: -1*CGFloat((M_PI/6)*2))
        lc.addSubview(tc)
        
        let ld = makeMark(200, 100, 20, 300, UIColor.black,  CGFloat((M_PI/6)*3))
        self.view.addSubview(ld)
        let td = makeLabel(0, 0, 80, 20, UIColor.white, "4")
        //td.transform = CGAffineTransform(rotationAngle: -1*CGFloat((M_PI/6)*3))
        ld.addSubview(td)
        
        let le = makeMark(200, 100, 20, 300, UIColor.black,  CGFloat((M_PI/6)*4))
        self.view.addSubview(le)
        let te = makeLabel(0, 0, 80, 20, UIColor.white, "5")
        //te.transform = CGAffineTransform(rotationAngle: -1*CGFloat((M_PI/6)*4))
        le.addSubview(te)
        
        

    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func makeLabel(_ x:Double,_ y:Double,_ width:Double,_ height:Double,_ color:UIColor,_ text:String) -> UILabel {
        let ml = UILabel()
        ml.frame = CGRect(x: x , y: y, width: width, height: height)
        ml.text = text
        ml.textColor = color
        return ml
    }

    
    func makeMark(_ x:Double,_ y:Double,_ width:Double,_ height:Double,_ color:UIColor,_ angle: CGFloat) -> UIView {
        let uv = UIView()
        uv.frame = CGRect(x: x , y: y, width: width, height: height)
        uv.backgroundColor = color
        uv.transform = CGAffineTransform(rotationAngle: angle)
        return uv
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



