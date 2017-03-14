//
//  fileControlTest.swift
//  testUIKit
//
//  Created by jun walker on 2017/3/14.
//  Copyright © 2017年 jun walker. All rights reserved.
//

import Foundation

import UIKit




class fileControlTest: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(jx_file_GetHomeDirectory())
        print(jx_file_GetDocumentDirectory())
 //       print(jx_file_GetDocumentDirectory(jx_file_GetHomeDirectory()))
 //       print(jx_file_GetDocumentDirectory(jx_file_GetDocumentDirectory()))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    ///确定home文件夹地址
    func jx_file_GetHomeDirectory() -> String {
        //获取程序的Home目录
        let homeDirectory = NSHomeDirectory()
        return homeDirectory
    }
    
    
    ///Document文件夹地址
    func jx_file_GetDocumentDirectory() -> String {
        
        let ducumentPath2 = NSHomeDirectory() + "/Documents"
        return ducumentPath2
    }
    ///Library文件夹地址
    func jx_file_GetLibraryDirectory() -> String {
        
        let libraryPath2 = NSHomeDirectory() + "/Library"
        return libraryPath2
    }
    ///Caches文件夹地址
    func jx_file_GetCachesDirectory() -> String {
        
        let cachePath2 = NSHomeDirectory() + "/Library/Caches"
        return cachePath2
    }
    ///tmp文件夹地址
    func jx_file_GettmpDirectory() -> String {
        
        let tmpDir2 = NSHomeDirectory() + "/tmp"
        return tmpDir2
    }
    
    /*
        //假设用户文档下有如下文件和文件夹[test1.txt,fold1/test2.txt]
        let manager = FileManager.default
        let urlForDocument = manager.urls( for: FileManager.SearchPathDirectory.documentDirectory, in:FileManager.SearchPathDomainMask.userDomainMask)
        let url = urlForDocument[0]
        return url.absoluteString
    }
    */
    
    
    ///取得目录下的所有文件
    func jx_file_contentOfPath (_ url:URL) -> Array<String>? {
        let manager = FileManager.default
        //（1）对指定路径执行浅搜索，返回指定目录路径下的文件、子目录及符号链接的列表
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: url.path)
        //contentsOfPath：Optional([fold1, test1.txt])
        //print("contentsOfPath: \(contentsOfPath)")
        
        return contentsOfPath!
    }
    
}

