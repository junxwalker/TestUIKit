//
//  presentVC_Test.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/7.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit

/*
 
 转场动画测试
 
 */

class presentVC_Test: UIViewController, UIViewControllerTransitioningDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        


        let diapButton: UIButton = UIButton(frame: CGRect(x:0,y:0,width:120,height:50))
        diapButton.backgroundColor = UIColor.red
        diapButton.layer.masksToBounds = true
        diapButton.setTitle("Display", for: .normal)
        diapButton.layer.cornerRadius = 20.0
        diapButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        //backButton.addTarget(self, action: #selector(onClickMyButton(_:)), forControlEvents: .TouchUpInside)
        diapButton.addTarget(self, action: #selector(presentVC_Test.onClickMyButton(sender:)), for: .touchUpInside)
        self.view.addSubview(diapButton);
        //#selector(GradientLayerTest.onClickMyButton(sender:))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // 声明一个动画实例
    private let transition = FadeAnimator()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    
    func onClickMyButton(sender: UIButton){

        
        let myViewController: UIViewController = nemuVC_a98b()
        myViewController.transitioningDelegate = self
        //myViewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(myViewController, animated: true, completion: nil)
    }

}

class FadeAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    private let duration = 0.25
    
    // 指定转场动画持续的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    // 实现转场动画的具体内容
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 得到容器视图
        let containerView = transitionContext.containerView
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // 目标视图
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        containerView.addSubview(toView!)
        //toView?.addSubview(fromView!)
        //fromView?.frame = CGRect(x: 200, y: 0, width: screenWidth, height: screenHeight)
        
        
        // 为目标视图的展现添加动画
        fromView?.alpha = 1

        toView?.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: duration, animations: {
            fromView?.alpha = 0.5
            toView?.frame = CGRect(x: -150, y: 0, width: screenWidth, height: screenHeight)
        }) { (finished) in
            // 结束动画过渡
            transitionContext.completeTransition(true)
        }
    }
}

class nemuVC_a98b: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        
        let backButton: UIButton = UIButton(frame: CGRect(x:0,y:0,width:120,height:50))
        backButton.backgroundColor = UIColor.red
        backButton.layer.masksToBounds = true
        backButton.setTitle("Back", for: .normal)
        backButton.layer.cornerRadius = 20.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        backButton.addTarget(self, action: #selector(nemuVC_a98b.onClickMyButton(sender:)), for: .touchUpInside)
        self.view.addSubview(backButton);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickMyButton(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }
}
