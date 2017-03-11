//
//  quadCurveTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/10.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import Foundation
import UIKit



class bezierTest: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   let cg2 = CGView2()
     //   cg2.frame = self.view.bounds
     //   self.view.addSubview(cg2)
        
        
        bezier_3(0,0, 10,80, 20,90, 100,100)
        
        
        let bs = bezier(CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 80), CGPoint(x: 20, y: 90), CGPoint(x: 100, y: 100), 200)
        print("bs: 0 ", bs(0))
        print("bs: 20 ", bs(20))
        print("bs: 80 ", bs(80))
        print("bs: 170 ", bs(170))
        print("bs: 200 ", bs(200))
    }
    
    func bezier(_ startPosition: CGPoint, _ secondPositon: CGPoint, _ thirdPosition: CGPoint, _ endPosition: CGPoint,
                _ rate: CGFloat) -> ( (CGFloat) -> CGPoint ) {
        return {    time in
            
            let t: CGFloat = (1.0/rate) * time
            let yt:CGFloat = 1 - t
            let t1:CGFloat = yt * yt
            let t2:CGFloat = 3 * yt * t
            
            let xp = (startPosition.x * t1 * yt) + (secondPositon.x * t2 * yt) + (thirdPosition.x * t2 * t) + (endPosition.x * t * t * t)
            let yp = (startPosition.y * yt * t1) + (secondPositon.y * t2 * yt) + (thirdPosition.y * t2 * t) + (endPosition.y * t * t * t)
            return CGPoint(x: xp, y: yp)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func bezier_3(_ x0:Double, _ y0:Double, _ x1:Double, _ y1:Double, _ x2:Double, _ y2:Double, _ x3:Double, _ y3:Double ) {
        
        var t:Double = 0
        var t1:Double = 0
        var t2:Double = 0
        var xt:Double = 0
        var yt:Double = 0
        let rate:Double = 199

        var time:Int = 0
        repeat {
            yt = 1 - t
            t1 = yt * yt
            t2 = 3 * yt * t
            
            xt = (x0 * t1 * yt) + (x1 * t2 * yt) + (x2 * t2 * t) + (x3 * t * t * t)
            yt = (y0 * yt * t1) + (y1 * t2 * yt) + (y2 * t2 * t) + (y3 * t * t * t)
            
            
            t = t + 1.0/rate
            
            time = time + 1
            print("p: ",time, " - ", t, " ------- ", Int(xt), Int(yt))
        } while ( t <= 1 )
        
        
        yt = 1 - t
        t1 = yt * yt
        t2 = 3 * yt * t
        
        xt = (x0 * t1 * yt) + (x1 * t2 * yt) + (x2 * t2 * t) + (x3 * t * t * t)
        yt = (y0 * yt * t1) + (y1 * t2 * yt) + (y2 * t2 * t) + (y3 * t * t * t)
        time = time + 1
        print("pend: ",time, " - ", t, " ------- ", Int(xt), Int(yt))
        
        print("77 - ", ((1.0)/rate)*77 )
        print("177 - ", ((1.0)/rate)*177 )
    }

    

    
    
    
}


class CGView2:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建一个矩形，它的所有边都内缩3点
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        //移动起点
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        //二次贝塞尔曲线终点
        let toPoint = CGPoint(x: drawingRect.maxX, y: drawingRect.maxY)
        //二次贝塞尔曲线控制点
        let controlPoint = CGPoint(x: drawingRect.midX, y: drawingRect.minY)
        //绘制二次贝塞尔曲线
        path.addQuadCurve(to: toPoint, control: controlPoint)
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()
        
        path.apply(info: nil) { (_, elementPointer) in
            let element = elementPointer.pointee
            let command: String
            let pointCount: Int
            switch element.type {
            case .moveToPoint: command = "moveTo"; pointCount = 1
            case .addLineToPoint: command = "lineTo"; pointCount = 1
            case .addQuadCurveToPoint: command = "quadCurveTo"; pointCount = 2
            case .addCurveToPoint: command = "curveTo"; pointCount = 3
            case .closeSubpath: command = "close"; pointCount = 0
            }
            let points = Array(UnsafeBufferPointer(start: element.points, count: pointCount))
            Swift.print("\(command) \(points)")
            

        }
        let a = path.copy()
        print("path.copy: ",a!)
    }
}



