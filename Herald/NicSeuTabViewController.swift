//
//  NicSeuTabViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/4/4.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class NicSeuTabViewController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        
        self.selectedIndex = 0;//默认选中第一个Tab
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self.selectedViewController, action: Selector("refreshData"))
        //默认加载第一个Tab的按钮
        self.navigationItem.rightBarButtonItem = refreshButton
        
        self.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        Tool.dismissHUD()
    }
    
    func tabBarController(tabBarController: UITabBarController,
        didSelectViewController viewController: UIViewController){
            let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: viewController, action: Selector("refreshData"))
            let detailButton = UIBarButtonItem(title: "消费详情", style: UIBarButtonItemStyle.Plain, target: viewController, action: Selector("detailInfo"))
            
            if viewController.tabBarItem.title == "校园网"{
                self.navigationItem.rightBarButtonItem = refreshButton
            }
            else{
                self.navigationItem.rightBarButtonItem = detailButton
            }
    }

}
