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
    
    
    let f = Test_View(frame: CGRect(x:100, y:180, width:200, height:100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        
        createGradientLayer()

        
        //f.backgroundColor = UIColor.blue

        //f.layer.shouldRasterize = true
        
        //UIViewAnimation4()
        self.view.addSubview(f)
        f.layer.cornerRadius = 5
        
        let tt = UILabel()
        tt.text = "12345"
        tt.textColor = UIColor.blue
        tt.frame = CGRect(x: 0, y: 0, width: 60, height: 10)
        f.addSubview(tt)
        //f.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
 
        /*
        CATransaction.begin()
        CATransaction.setAnimationDuration(2.0)
        grad.locations = [0, 0.1, 1]
        CATransaction.commit()
         */
        

        print("viewDidLoad")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [ UIColor.red.cgColor,UIColor.green.cgColor,UIColor.blue.cgColor]
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    
    func UIViewAnimation4(){
        UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [ .repeat, .autoreverse], animations: {
            
            //注意:对于有圆角的视图,改变大小而不改变形状,只能通过形变去缩放,不能改变frame的size就改变大小
            //self.subView.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(0, -240), CGFloat(M_PI_2))
            self.f.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        }, completion: nil)
        
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        //let h = rect.height
        //let w = rect.width
        let color:UIColor = UIColor.yellow
        
        //let drect = CGRect(x: (w * 0.25),y: (h * 0.25),width: (w * 0.5),height: (h * 0.5))
        let drect = rect
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        
        color.set()             //设定要画的颜色
        bpath.lineWidth  = 5 //路径宽度
        //bpath.lineCapStyle =  kCALineCapRound //端点样式(枚举)
        bpath.stroke()          //渲染路径
        //UIColor.red.setFill() //设置填充颜色(不常用)
        bpath.fill()            //渲染填充部分
        
        NSLog("drawRect has updated the view")
        
        
        
        //let context = UIGraphicsGetCurrentContext()
        //con
        
       // let a = UIImage(named: "002185")
       // a?.draw(in:  rect)
        
    }
    
}



