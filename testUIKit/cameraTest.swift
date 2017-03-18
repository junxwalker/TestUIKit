//
//  cameraTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/18.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit


/*
 
    Info.list   [ 加上  Privacy - Camera Usage Description ]
 
 
 */

class cameraTest: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let takePicBtn = UIButton()
        takePicBtn.addTarget(self, action:#selector(cameraTest.takePictureButton), for: .touchUpInside)
        takePicBtn.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
        takePicBtn.backgroundColor = UIColor.blue
        self.view.addSubview(takePicBtn)
        
        
        
        

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("本装置具备拍照功能")
            
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                print("有前镜头")
            }
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                print("有后镜头")
            }
            if UIImagePickerController.isFlashAvailable(for: .front) {
                print("有前闪光灯")
            }
            if UIImagePickerController.isFlashAvailable(for: .rear) {
                print("有后闪光灯")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func takePictureButton(_ sender: AnyObject) {
        //检查装置是否具备拍照功能
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerVC = UIImagePickerController()
            // 设定相片来源为相机
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            // 开启拍照界面
            show(imagePickerVC, sender:  self)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //取得拍下来的照片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //将相片存到相簿
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    // 按下取消拍照按钮
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
