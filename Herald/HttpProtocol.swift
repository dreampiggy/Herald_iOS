//
//  HttpController.swift
//  先声
//
//  Created by Wangshuo on 14-8-1.
//  Copyright (c) 2015年 WangShuo,Li Zhuoli. All rights reserved.
//

import Foundation
import UIKit

@objc protocol HttpProtocol
{
    optional func didReceiveDicResults(results:NSDictionary?,tag:String)
    optional func didReceiveArrayResults(results:NSArray?,tag:String)
    optional func didReceiveStringResults(results:NSString?,tag:String)
    optional func didReceiveDataResults(results:NSData?,tag:String)
    optional func didReceiveErrorResult(code:Int,tag:String)
}