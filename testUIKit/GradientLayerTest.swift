//
//  uiviewTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/4.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit
import CoreImage

/*
    GradientLayer  测试
 
    CAGradientLayer是用来生成两种或更多颜色平滑渐变的,  使用了[硬件加速]
 
 
 */

class GradientLayerTest: UIViewController {
    
    let lightBarWidth:Double = 300
    let lightBarHeight:Double = 12
    let startMoveX:Double = -500
    let endMoveX:Double = 500
    
    var grad:CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aniView = UIView()
        aniView.frame = CGRect(x: 20, y: 200, width: lightBarWidth, height: lightBarHeight)
        aniView.backgroundColor = UIColor.gray
        self.view.addSubview(aniView)
        
        grad = Test_CAGradientLayer()
        grad?.frame = CGRect(x: startMoveX, y: 0, width: lightBarWidth, height: lightBarHeight)
        aniView.layer.addSublayer(grad!)
        
        let maskLayer = CALayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: lightBarWidth, height: lightBarHeight)
        maskLayer.backgroundColor = UIColor.black.cgColor
        aniView.layer.mask = maskLayer
        
        
        let myButton = UIButton()
        myButton.frame = CGRect(x: 20 , y: 400, width: 100, height: 50)
        myButton.backgroundColor = UIColor.red
        myButton.layer.cornerRadius = 8
        myButton.addTarget(self, action: #selector(GradientLayerTest.onClickMyButton(sender:)), for: .touchUpInside)
        self.view.addSubview(myButton)
    }
    
    internal func onClickMyButton(sender: UIButton) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        if self.grad?.frame.origin.x  == CGFloat(endMoveX) {
            self.grad?.frame = CGRect(x: startMoveX, y: 0, width: lightBarWidth, height: lightBarHeight)
        } else {
            self.grad?.frame = CGRect(x: endMoveX, y: 0, width: lightBarWidth, height: lightBarHeight)
        }
        CATransaction.commit()
    }
    
    func Test_CAGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.gray.cgColor,UIColor.white.cgColor,UIColor.gray.cgColor]
        gradient.locations = [0, 0.2, 0.5]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        return  gradient
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}








