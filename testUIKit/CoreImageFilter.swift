//
//  CoreImageFilter.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/1.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import UIKit
import CoreImage

/*

    滤镜使用测试.     使用 Functional Programming 写法. 
 
 关于CoreImage
 
 Core Image 介绍
 https://objccn.io/issue-21-6/
 ios 开发者工具
 https://developer.apple.com/downloads/index.action?name=Graphics
 
 Core Image 的权威文档集。
 https://developer.apple.com/reference/coreimage#//apple_ref/doc/uid/TP40001171
 Core Image 提供的图像滤镜的完整列表，以及用法示例
 https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346
 
 
 
    重点:
    kCIInputImageKey 等等的關鍵字為 濾鏡使用時的參數名,  但ios系統只定義了少部分所以濾鏡的使用分為兩種.
    A) 系統已定義參數名
        let sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(1, forKey: kCIInputIntensityKey)          <- 參數:kCIInputIntensityKey : 已定義
    B) 參數名未在系統中定義
        let sepiaFilter = CIFilter(name: "CIColorPosterize")
        sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)      <- 參數:kCIInputImageKey : 已定義
        sepiaFilter?.setValuesForKeys([ "inputLevels" : 3])             <- 參數 inputLevels : 未定義
 
 

*/


class CoreImageFilter: UIViewController {
    
    typealias Filter = (CIImage) -> CIImage

    
    // 中值濾波器 (Median Filter)  -> 去圖片雜點, 平滑和降噪.
    // 计算一组邻近像素的平均数，然后用平均数替代每个像素的值。
    func fn_Median_中值濾波器() -> Filter {
        return { image in
            let parametes = [
                kCIInputImageKey: image
                ] as [String : Any]
            let filter = CIFilter(name: "CIMedianFilter", withInputParameters: parametes)
            let outputImage = filter?.outputImage
            return outputImage!
        }
    }
    
    func fn_blur_高斯模糊濾鏡(radius: Double) -> Filter {
        return { image in
            let parametes = [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: image
            ] as [String : Any]
            let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parametes)
            let outputImage = filter?.outputImage
            return outputImage!
        }
    }
    
    func fn_colorGenerator_顏色生成濾鏡(color: UIColor) -> Filter {
        return { _ in
            let filter = CIFilter(name:"CIConstantColorGenerator", withInputParameters: [kCIInputColorKey: CIColor(color: color)])
            let outputImage = filter?.outputImage
            return outputImage!
        }
    }
    
    func fn_compositeSourceOver_合成濾鏡(overlay: CIImage) -> Filter {
        return { image in
            let parameters = [
                kCIInputBackgroundImageKey: image,
                kCIInputImageKey: overlay
            ]
            let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters)
            let outputImage = filter?.outputImage
            let cropRect = image.extent
            let outImage2 = outputImage?.cropping(to: cropRect)
            return outImage2!
        }
    }
    
    func fn_colorOverlay_顏色疊層濾鏡(color: UIColor) -> Filter {
        return { image in
            let overlay = self.fn_colorGenerator_顏色生成濾鏡(color: color)(image)
            return self.fn_compositeSourceOver_合成濾鏡(overlay: overlay)(image)
        }
    }
    
    func measure(title: String!, call: () -> Void) {
        let startTime = CACurrentMediaTime()
        call()
        let endTime = CACurrentMediaTime()
        if let title = title {
            print("\(title): ")
        }
        print("Time - \(endTime - startTime)")
    }
    
    override func viewDidLoad() {
        
        
        
        let picView:UIImageView = {
            $0.backgroundColor = UIColor.red
            $0.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
            //           $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        } (UIImageView())
        self.view.addSubview(picView)
        
       
        guard let oldimage = UIImage(named: "002185") else {
            print("imageView doesn't have an image!")
            return
        }
        
        var result:UIImage?
        
        measure(title: "fn_濾鏡處理_時間計算") {
            //let ii = oldimage.cgImage
            let image =  CIImage(image: oldimage)!
            //let blurRadius = 5.0
            //let blurredImage = fn_blur_高斯模糊濾鏡(radius: blurRadius)(image)
            //print("main: blurredImage. ",blurredImage)
            
            //let overlayColor = UIColor.white.withAlphaComponent(0.2)
            //let overlaidImage = fn_colorOverlay_顏色疊層濾鏡(color: overlayColor)(blurredImage)
            //print("main: overlaidImage. ",overlaidImage)
            
            let medianImage = fn_Median_中值濾波器()(image)
            
            result = UIImage(ciImage: medianImage)
        }
        
        measure(title: "fn_濾鏡處理_使用openGL加速耗時計算") {
            let openGLContext = EAGLContext(api: .openGLES2)
            let context = CIContext(eaglContext: openGLContext!)
            
        
            //let ii = oldimage.cgImage
            let image =  CIImage(image: oldimage)!
        
        
        
        
            //let blurRadius = 5.0
            //let blurredImage = fn_blur_高斯模糊濾鏡(radius: blurRadius)(image)
            //print("main: blurredImage. ",blurredImage)

            //let overlayColor = UIColor.white.withAlphaComponent(0.2)
            //let overlaidImage = fn_colorOverlay_顏色疊層濾鏡(color: overlayColor)(blurredImage)
            //print("main: overlaidImage. ",overlaidImage)
            
            let medianImage = fn_Median_中值濾波器()(image)
        
            //let result = UIImage(ciImage: medianImage)
            //picView.image = result
        
            let output = context.createCGImage(medianImage, from: medianImage.extent)
            result = UIImage(cgImage: output!)
        }

        picView.image = result

    }
    
    func testFilter2() {
        
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
        
        //*** Filter 濾鏡設定.  
        //濾鏡列表:  https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW29
        //
        // 每個濾鏡對應不同參數.  詳細濾鏡及參數資料 參考上面網址.
        // 參數設定方式. 分為預定義以及 非預定義.   因為ios source 沒有定義完整的參數.
        // ***  ***  ***  ***  ***  ***  ***  ***  ***  ***  ***  ***  ***  ***  *** 
        
        // 濾鏡設定方式一.  參數已預定義
        //let sepiaFilter = CIFilter(name: "CISepiaTone")
        //sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        //sepiaFilter?.setValue(1, forKey: kCIInputIntensityKey)
        
        // 濾鏡設定方式二.  參數未在系統中定義
        let sepiaFilter = CIFilter(name: "CIColorPosterize")
        sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValuesForKeys([ "inputLevels" : 3])

        
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
        
        var img1:CIImage = CIImage(image: image)!
        img1 = img1.applyingFilter("CIPhotoEffectMono", withInputParameters:["inputImage" : img1])
        
        
        //  *************************
        //   打印全部滤镜, 及参数
        //  *************************
        let properties = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        print(properties)
        var n=0
        for fileterName : String in properties {
            let filter = CIFilter(name: fileterName)
            // 滤镜的参数
            print(n, fileterName," --- ",filter?.attributes as Any)
            n = n + 1
        }
 
        
    }
    
    /**
     查看所有内置滤镜
     */
    func showAllFilters() {
        let filterNames = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        for filterName in filterNames {
            let filter = CIFilter(name: filterName)
            print(filterName, filter?.attributes as Any)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
