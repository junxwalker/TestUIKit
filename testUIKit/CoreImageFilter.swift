//
//  CoreImageFilter.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/1.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit
import CoreImage

class CoreImageFilter: UIViewController {
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        
        
        let picView:UIImageView = {
            $0.backgroundColor = UIColor.red
            $0.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
            //           $0.translatesAutoresizingMaskIntoConstraints = false

            return $0
        } (UIImageView())
        self.view.addSubview(picView)
        

        guard let image = UIImage(named: "001859"), let cgimg = image.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        
        let openGLContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: openGLContext!)
        
        let coreImage = CIImage(cgImage: cgimg)
        
        let sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(1, forKey: kCIInputIntensityKey)
        
        //let sepiaFilter = CIFilter(name: "CIColorPosterize")
        //sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        //sepiaFilter?.setValue(1.00, forKey: kCInputLevelsKey)
        
        if let sepiaOutput = sepiaFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
            /*
             let exposureFilter = CIFilter(name: "CIExposureAdjust")
             exposureFilter?.setValue(sepiaOutput, forKey: kCIInputImageKey)
             exposureFilter?.setValue(1, forKey: kCIInputEVKey)
             */
            let exposureFilter = CIFilter(name: "CIColorPolynomial")
            exposureFilter?.setValue(sepiaOutput, forKey: kCIInputImageKey)
            
            if let exposureOutput = exposureFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
                let output = context.createCGImage(exposureOutput, from: exposureOutput.extent)
                let result = UIImage(cgImage: output!)
                picView.image = result
            }
        }
        
        
        
    }
}
