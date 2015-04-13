//
//  LibraryViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-5.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "东大图书馆"
        self.setupLeftMenuButton()
        
        var color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupLeftMenuButton()
    {
        let image = UIImage(named: "leftButton.png")
        let leftDrawerButton = UIButton(frame: CGRectMake(0, 0, 28, 28))
        leftDrawerButton.setBackgroundImage(image, forState: UIControlState.Normal)
        
        leftDrawerButton.addTarget(self, action: Selector("leftDrawerButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftButton:UIBarButtonItem = UIBarButtonItem(customView: leftDrawerButton)
        
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: true)
    }
    
    func leftDrawerButtonPress(sender:AnyObject)
    {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
  
    @IBAction func clickLibNav(sender: UIButton)
    {
  
        let LibNavVC = LibNavViewController(nibName: "LibNavViewController", bundle: nil)
        self.navigationController!.pushViewController(LibNavVC, animated: true)
        
    }
    
    @IBAction func clickSearchBook(sender: UIButton)
    {
        
        let SearchBookVC = SearchBookViewController()
        
        self.navigationController!.pushViewController(SearchBookVC, animated: true)
    }
    
    
    @IBAction func clickBorrowed(sender: UIButton)
    {
        if Config.UUID!.isEmpty
        {
            Tool.showErrorHUD("先去图书馆登录一下吧")
            
            let LibloginVC = UserInfoViewController()
            
            let LibNavVC = CommonNavViewController(rootViewController: LibloginVC)
            self.presentViewController(LibNavVC, animated: true, completion: nil)
        }
        else
        {
            let BorrowedBooksVC = BorrowedBooksViewController(nibName: "BorrowedBooksViewController", bundle: nil)
            
            self.navigationController!.pushViewController(BorrowedBooksVC, animated: true)
        }
        
    }
    
    
    @IBAction func clickSchoolBus(sender: UIButton) {
        if Config.UUID!.isEmpty
        {
            Tool.showErrorHUD("先去图书馆登录一下吧")
            
            let LibloginVC = UserInfoViewController()
            
            let LibNavVC = CommonNavViewController(rootViewController: LibloginVC)
            self.presentViewController(LibNavVC, animated: true, completion: nil)
        }
        else{
            let SchoolBusVC = SchoolBusViewController(nibName: "SchoolBusViewController", bundle: nil)
            
            self.navigationController!.pushViewController(SchoolBusVC, animated: true)
        }
    }

}
