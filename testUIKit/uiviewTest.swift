//
//  uiviewTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/4.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit
import CoreImage



class uiviewTest: UIViewController {
    
    
    let f = Test_View(frame: CGRect(x:100, y:180, width:100, height:20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        


        
        
        createGradientLayer()

        

        
        self.view.addSubview(f)
        f.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
 
        /*
        CATransaction.begin()
        CATransaction.setAnimationDuration(2.0)
        grad.locations = [0, 0.1, 1]
        CATransaction.commit()
         */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
}





// 测试UIView draw() 画线.

class Test_View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override func draw(_ rect: CGRect) {
        let h = rect.height
        let w = rect.width
        let color:UIColor = UIColor.yellow
        
        //let drect = CGRect(x: (w * 0.25),y: (h * 0.25),width: (w * 0.5),height: (h * 0.5))
        let drect = rect
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        //下面这几个属性要用在UIView中重写drawRect:方法中使用才有效，否则不会出现效果
        
        color.set()             //设定要画的颜色
        bpath.lineWidth  = 5 //路径宽度
        //bpath.lineCapStyle =  kCALineCapRound //端点样式(枚举)
        bpath.stroke()          //渲染路径
        //UIColor.red.setFill() //设置填充颜色(不常用)
        //bpath.fill()            //渲染填充部分
        
        NSLog("drawRect has updated the view")
        
    }
    
}
