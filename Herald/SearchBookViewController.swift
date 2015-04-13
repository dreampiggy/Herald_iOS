//
//  SearchBookViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-5.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class SearchBookViewController: UIViewController {

    
    var textField: UITextField!
    var screenSize:CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "书籍查询"
        
        var color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 1)
        self.view.backgroundColor = color
        
        
        self.textField = UITextField(frame: CGRectMake((self.screenSize.width - self.screenSize.width/1.21)/2, self.screenSize.height/5, self.screenSize.width/1.21, 41))
        self.textField.backgroundColor = UIColor.whiteColor()
        self.textField.layer.cornerRadius = 3.0
        self.textField.placeholder = "请输入书名"
        self.textField.font = UIFont(name: "Avenir-Book", size: 16)
        self.textField.returnKeyType = UIReturnKeyType.Search
        
        
        var searchRippleButton = BTRippleButtton(image: UIImage(named: "SearchBook.jpeg"), andFrame: CGRectMake((self.screenSize.width - 80)/2, self.screenSize.height/3.3, 80, 80), andTarget: Selector("search"), andID: self)
        searchRippleButton.setRippeEffectEnabled(true)
        searchRippleButton.setRippleEffectWithColor(UIColor(red: 240/255, green:159/255, blue:10/255, alpha:1))
        
        self.view.addSubview(self.textField)
        self.view.addSubview(searchRippleButton)

    }

    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
    }

    func search()
    {
        var text = self.textField.text
        
        let DetailVC = SearchBookDetailViewController(nibName: "SearchBookDetailViewController", bundle: nil)
        DetailVC.searchText = text
        
        self.navigationController!.pushViewController(DetailVC, animated: true)
    }
}
