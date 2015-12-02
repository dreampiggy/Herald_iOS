//
//  AcademicDetailViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-2.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class AcademicDetailViewController: UIViewController {

    var url:String?
    var text:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if url != nil
        {
            self.initWebView(self.url!)
        }
    }
    
    func initWebView(url:String)
    {
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
       // screenBounds.origin.y += 20   //状态栏高度
        let webView :UIWebView = UIWebView(frame: screenBounds)
        webView.scalesPageToFit = true
        
        self.view.addSubview(webView)
        
        Tool.showProgressHUD("正在加载")
        let requestURL:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: requestURL)
        webView.loadRequest(request)
        Tool.showSuccessHUD("加载成功")
        
    }

}
