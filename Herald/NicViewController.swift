//
//  NicViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/4/4.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class NicViewController: UIViewController, APIGetter {

    var firstSend = true
    
    struct networkInfo {
        var state:String?
        var used:String?
    }
    var networkArray = [networkInfo?]()
    
    @IBOutlet weak var nicMoneyLabel: UILabel!
    @IBOutlet weak var networkInfoText: UITextView!
    @IBOutlet weak var networkSegmentedControl: UISegmentedControl!
    
    @IBAction func networkSegmentedSelected(sender: UISegmentedControl) {
        var selectedNetworkType = sender.selectedSegmentIndex
        drawNetworkInfo(selectedNetworkType)
    }
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        
        var initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询校园网信息")
            self.API.delegate = self
            API.sendAPI("nic")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: JSON) {
        Tool.showSuccessHUD("获取信息成功")
        
        let leftMoney = results["content"]["left"].string ?? "0.00 元"
        
        let webState = results["content"]["web"]["state"].string ?? "未知"
        let webUsed = results["content"]["web"]["used"].string ?? "未知"
        let webStruct = networkInfo(state: webState, used: webUsed)

        let brasAState = results["content"]["a"]["state"].string ?? "未知"
        let brasAUsed = results["content"]["a"]["used"].string ?? "未知"
        let brasAStruct = networkInfo(state: brasAState, used: brasAUsed)
        
        let brasBState = results["content"]["b"]["state"].string ?? "未知"
        let brasBUsed = results["content"]["b"]["used"].string ?? "未知"
        let brasBStruct = networkInfo(state: brasBState, used: brasBUsed)
        
        networkArray.append(webStruct)
        networkArray.append(brasAStruct)
        networkArray.append(brasBStruct)
        
        firstSend = false
        nicMoneyLabel.text = leftMoney
        
        drawNetworkInfo(networkSegmentedControl.selectedSegmentIndex)
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func drawNetworkInfo(networkType:Int){
        if !networkArray.isEmpty{
            var networkInfo = "\n状态：\n" + networkArray[networkType]!.state! + "\n\n已使用：\n" + networkArray[networkType]!.used!
            networkInfoText.text = networkInfo
        }
        else{
            Tool.showErrorHUD("获取数据失败")
        }
    }
    
    func refreshData(){
        Tool.showProgressHUD("正在更新数据")
        networkArray.removeAll(keepCapacity: true)
        API.sendAPI("nic")
    }

}
