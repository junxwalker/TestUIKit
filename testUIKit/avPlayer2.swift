//
//  VideoViewController.swift
//  SideMenuCALayerDemo
//
//  Created by 默司 on 2017/3/1.
//  Copyright © 2017年 默司. All rights reserved.
//
import UIKit
import AVFoundation

class VideoViewController: UIViewController {
    
    //@IBOutlet weak var videoRectView: UIView! // 拿來給 PlayerLayer 追蹤位置
    var videoRectView = UIView()
    
    var touchStartPoint: CGPoint! // 紀錄拖拉的起始位置
    
    var maxOffset: CGFloat { // 最多可以拉多遠
        return UIScreen.main.bounds.size.height - minHeight
    }
    
    var minWidth: CGFloat { // 縮到最小後的寬度
        return UIScreen.main.bounds.size.width / 4
    }
    
    var minHeight: CGFloat { // 縮到最小後的高度
        return minWidth / 16 * 9
    }
    
    var maxWidth: CGFloat { // 原始寬度
        return UIScreen.main.bounds.size.width
    }
    
    var maxHeight: CGFloat { // 原始高度
        return UIScreen.main.bounds.size.height
    }
    
    //    var aspectRatio: CGFloat { // 原始長寬比 (後來沒用到)
    //        return maxWidth / maxHeight
    //    }
    
    var offset: CGFloat = 0 // 記錄目前當前移動量
    var startOffset: CGFloat = 0 // 開始拖拉時的移動量
    var tap: UITapGestureRecognizer! // Tap手勢，點一下回到最大
    var videoPlayer = AVPlayer() // 播放影片
    
    /*
        junxwalker
        这里设定有问题,  应该设定为 AVPlayerLayer 才对.
        设定为 CALayer 也可以但是缺少 AVPlayerLayer 的功能
    */
    var videoLayer: CALayer! // VideoPlayer Layer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.videoRectView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:200)
        self.view.addSubview(self.videoRectView)
        /*
            junxwalker
            这里必需加上 videoRectView 与 view 的边界关系,  因为在下面拖拉缩放的部分, video缩放的大小位置是根据 videoRectView 而来.
            而 videoRectView 的大小位置 则是因为边界绑定了view,所以系统会自动计算调整.
         
            这里的做法是利用ios autolayout 的功能自动计算了!
        */
        
        // Do any additional setup after loading the view.
        // 拖拉手勢
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:))))
        // Tap 手勢初始化
        self.tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        self.tap.isEnabled = false // 預設關閉
        self.view.addGestureRecognizer(tap)
        // 建立 Layer (背景黑黑der)
        self.videoLayer = AVPlayerLayer(player: videoPlayer)
        self.videoLayer.backgroundColor = UIColor.black.cgColor
        
        // Layer 加到最上面
        self.view.layer.addSublayer(videoLayer)
        // 不知道哪裡找來的影片連結
        let url = URL(string: "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4")
        let playerItem = AVPlayerItem(url: url!)
        // 放到播放器裡面
        self.videoPlayer.replaceCurrentItem(with: playerItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 開始播放並設定好顯示範圍
        self.videoPlayer.play()
        self.videoLayer.frame = self.videoRectView.frame
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deviceOrientationDidChange(_ notification: NSNotification) {
        self.toMax() // 只要有轉向都先把縮小取消 (和 Youtube 行為相同)
        
        switch UIDevice.current.orientation {
        case .landscapeLeft: // HOME在左邊
            let bounds = UIScreen.main.bounds
            self.videoLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1) // 先轉 (CALayer 自動補間)
            self.videoLayer.frame = bounds // 再設定 frame (CALayer 自動補間)
            break
        case .landscapeRight:
            let bounds = UIScreen.main.bounds
            self.videoLayer.transform = CATransform3DMakeRotation(CGFloat.pi / -2, 0, 0, 1) // 先轉 (CALayer 自動補間)
            self.videoLayer.frame = bounds // 再設定 frame (CALayer 自動補間)
            break
        default:
            self.videoLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1) // 先轉 (CALayer 自動補間)
            self.videoLayer.frame = self.videoRectView.frame // 再設定 frame (CALayer 自動補間)
            break
        }
    }
    
    func tapHandler(_ gesture: UITapGestureRecognizer) {
        self.toMax() //點一下回去最大的狀態
    }
    
    func panHandler(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.touchStartPoint = gesture.location(in: self.view.superview) // 紀錄觸控起點
            
            break
        case .changed:
            let position = gesture.location(in: self.view.superview) // 拖拉中，目前的觸控點
            
            self.offset = position.y - touchStartPoint.y // 位移
            
            let y = min(startOffset + offset, maxOffset) // View 的新 y 座標
            var height = maxHeight - y // 用 y 座標算新高度
            
            if height > maxHeight { height = maxHeight }
            if height < minHeight { height = minHeight }
            
            var width = minWidth * (height / maxHeight) * 4 // 用高度算新寬度
            
            if width > maxWidth { width = maxWidth }
            if width < minWidth { width = minWidth }
            
            let x = maxWidth - width // 用寬度算新 x 座標
            print("136 ---- ", UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            self.view.frame = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)) // 合體
            print("view --- ", self.view.frame)
            //self.videoLayer.frame = self.videoRectView.frame
            CATransaction.begin() // 使用自動補間會跟不上拖拉速度
            CATransaction.setDisableActions(true) // 所以這邊要取消自動補間
            /*
                junxwalker
                videoRectView 在SB中与 super view 边界绑定了,  所以上面设定 self.view.frame 时会跟着自动调整 videoRectView 的位置大小.
                所以这里才可以利用 videoRectView.frame 取得正确的 self.videoLayer.frame
            */
            self.videoLayer.frame = self.videoRectView.frame
            print("videoRectView --- ", self.videoRectView.frame)
            CATransaction.commit() // 自己設定新的參數後要 commit
            
            break
        case .ended: // 放開那個女孩...不對...那個 View 的時候，依照拖拉目前高度判斷要往最大還是最小發展
            if self.offset > maxHeight / 2 {
                self.toMin()
            } else {
                self.toMax()
            }
            break
        default:
            break
        }
    }
    
    func toMin() {
        UIView.animate(withDuration: 0.2, animations: {
            let size = CGSize(width: self.minWidth, height: self.minHeight)
            self.view.frame = CGRect(origin: CGPoint(x: self.maxWidth - size.width, y: self.maxHeight - size.height), size: size)
            self.view.layoutIfNeeded() // 沒有這行 subview 會直接抵達終點
        })
        self.startOffset = maxOffset
        self.tap.isEnabled = true // 縮小後 Tap 啟用
        self.videoLayer.frame = self.videoRectView.frame // Layer跟上 (CALayer自動補間)
    }
    
    func toMax() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame = CGRect(origin: .zero, size: CGSize(width: self.maxWidth, height: self.maxHeight))
            self.view.layoutIfNeeded() // 沒有這行 subview 會直接抵達終點
        })
        self.startOffset = 0
        self.tap.isEnabled = false // 放大後 Tap 停用
        self.videoLayer.frame = self.videoRectView.frame // Layer跟上 (CALayer自動補間)
    }
}
