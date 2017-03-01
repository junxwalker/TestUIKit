//
//  avPlayer.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/1.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit
import AVFoundation


class avPlayer: UIViewController {
    var mvView:UIView!
    var playerItem:AVPlayerItem!
    var avplayer:AVPlayer!
    var playerLayer:AVPlayerLayer!
    var link:CADisplayLink!
    
    var ti = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /*
        let upView:UIView = {
            $0.backgroundColor = UIColor.red
            $0.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:200)
            //           $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        } (UIView())
        self.view.addSubview(upView)
        */
        let url = URL(string: "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4")
        playerItem = AVPlayerItem(url: url!)
        self.avplayer = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: avplayer)
        playerLayer.videoGravity = AVLayerVideoGravityResize
        playerLayer.frame = CGRect(x: 0, y: 0, width:100, height:100)
        self.view.layer.addSublayer(playerLayer)
        
        self.link = CADisplayLink(target: self, selector: #selector(update))
        self.link.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        
        self.avplayer.play()
    }
    
    func update(){
        ti = ti + 1
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(5)
        
        if ti == 300 {
            playerLayer.frame = CGRect(x: playerLayer.frame.origin.x+300, y: playerLayer.frame.origin.y+400, width: playerLayer.frame.width, height: playerLayer.frame.height)
        } else if ti == 600 {
            playerLayer.frame = CGRect(x: 0, y: playerLayer.frame.origin.y, width: playerLayer.frame.width, height: playerLayer.frame.height)
        } else if ti == 900 {
            playerLayer.frame = CGRect(x: 0, y: playerLayer.frame.origin.y-400, width: playerLayer.frame.width, height: playerLayer.frame.height)
            playerLayer.opacity = 0.0 //透明
        } else if ti == 1200 {
            playerLayer.frame = CGRect(x: playerLayer.frame.origin.x, y: playerLayer.frame.origin.y+400, width: playerLayer.frame.width+200, height: playerLayer.frame.height+200)
            playerLayer.transform = CATransform3DMakeRotation(7.2, 0, 0, 1); //绕Z轴旋转
            playerLayer.opacity = 1.0 //透明
        } else if ti == 1500 {
            playerLayer.frame = CGRect(x: playerLayer.frame.origin.x, y: playerLayer.frame.origin.y-400, width: playerLayer.frame.width, height: playerLayer.frame.height)
            playerLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1); //旋转归位
        } else if ti == 1800 {
            playerLayer.frame = CGRect(x: playerLayer.frame.origin.x, y: playerLayer.frame.origin.y, width: playerLayer.frame.width-100, height: playerLayer.frame.height-250)
        } else if ti == 2100 {
            playerLayer.frame = CGRect(x: playerLayer.frame.origin.x, y: playerLayer.frame.origin.y+400, width: playerLayer.frame.width, height: playerLayer.frame.height+100)
            playerLayer.opacity = 0.1 //透明
        }
        CATransaction.commit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
