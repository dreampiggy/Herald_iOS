//
//  RunningViewController.swift
//  先声
//
//  Created by Wangshuo on 14-8-3.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class RunningViewController: UIViewController,APIGetter {

    @IBOutlet var gaugeView: WMGaugeView?
    var tickerLabel:ADTickerLabel?
    
    var screenSize:CGSize = UIScreen.mainScreen().bounds.size
    
    var YYLabel:UILabel?
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "跑操查询"
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refreshData"))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        self.setupView()
        //设置UIView背景

        self.view.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        self.gaugeView?.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        
        let initResult = Tool.initNavigationAPI(self)
        if initResult{
            Tool.showProgressHUD("正在获取跑操数据")
            self.API.delegate = self
            API.sendAPI("pe")
            API.sendAPI("running")
        }
        
    }

    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: JSON) {
        switch APIName {
        case "pe":
            let runContent:NSString = results["content"].string ?? "0"
            if (runContent.integerValue >= 0 && runContent.integerValue <= 100){
                Tool.showSuccessHUD("更新成功")
                self.gaugeView?.value = runContent.floatValue
                self.tickerLabel?.text = runContent as String
            }
        
        case "running":
            if let text = results["content"].string {
                if text == "refreshing" {
                    return
                } else {
                    YYLabel?.text = text
                }
            }
        default: break
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        switch APIName {
        case "pe":
            Tool.showErrorHUD("获取数据失败")
        default: break
        }
    }
    
    func setupView()
    {
        self.navigationItem.title = "跑操查询"
        
        let font:UIFont = UIFont.boldSystemFontOfSize(35)
        self.tickerLabel = ADTickerLabel(frame: CGRectMake((self.screenSize.width+font.lineHeight)/2, 410, 0, font.lineHeight))
        self.tickerLabel!.font = font
        self.tickerLabel!.characterWidth = 20
        self.tickerLabel!.changeTextAnimationDuration = 1
        self.view.addSubview(self.tickerLabel!)
        self.gaugeView!.maxValue = 60.0;
        self.gaugeView!.scaleDivisions = 12;
        self.gaugeView!.scaleSubdivisions = 5;
        self.gaugeView!.scaleStartAngle = 60;
        self.gaugeView!.scaleEndAngle = 300;
        self.gaugeView!.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat;
        self.gaugeView!.showScaleShadow = false;
        self.gaugeView!.scaleFont = UIFont(name: "AvenirNext-UltraLight", size: 0.065)
        self.gaugeView!.scalesubdivisionsaligment = WMGaugeViewSubdivisionsAlignmentCenter;
        self.gaugeView!.scaleSubdivisionsWidth = 0.002;
        self.gaugeView!.scaleSubdivisionsLength = 0.04;
        self.gaugeView!.scaleDivisionsWidth = 0.007;
        self.gaugeView!.scaleDivisionsLength = 0.07;
        self.gaugeView!.needleStyle = WMGaugeViewNeedleStyleFlatThin;
        self.gaugeView!.needleWidth = 0.012;
        self.gaugeView!.needleHeight = 0.4;
        self.gaugeView!.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain;
        self.gaugeView!.needleScrewRadius = 0.05;
        
        let YYRippleButton = BTRippleButtton(image: UIImage(named: "RunningYY"), andFrame: CGRectMake((self.screenSize.width - 70)/2, 300, 70, 70), andTarget: Selector("YY"), andID: self)
        YYRippleButton.setRippeEffectEnabled(true)
        YYRippleButton.setRippleEffectWithColor(UIColor(red: 240/255, green:159/255, blue:10/255, alpha:1))
        
        YYLabel = UILabel(frame: CGRectMake(0, 340, self.screenSize.width, 100))
        YYLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        YYLabel!.textAlignment = NSTextAlignment.Center
        YYLabel!.text = "现在还没有跑操预告哦"
        YYLabel?.font = UIFont.boldSystemFontOfSize(20)
        YYLabel!.textColor = UIColor.whiteColor()
        
        self.view.addSubview(YYRippleButton)
        self.view.addSubview(YYLabel!)
    }
    
    func YY()
    {
        let YYNum = Float(arc4random_uniform(60))
        self.gaugeView?.value = YYNum
        self.tickerLabel?.text = NSString(format: "%.0f", YYNum) as String
    }
    
    func refreshData()
    {
        Tool.showProgressHUD("正在更新")
        API.sendAPI("pe")
    }

}
