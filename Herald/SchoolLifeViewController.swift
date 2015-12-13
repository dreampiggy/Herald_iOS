//
//  SchoolLifeViewController.swift
//  先声
//
//  Created by Wangshuo on 14-8-29.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class SchoolLifeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "校园生活"
        let color = UIColor(red: 119/255, green: 202/255, blue: 184/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        
        self.setupLeftMenuButton()
        
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
    
    @IBAction func runningButton(sender: AnyObject)
    {
        let runningVC = RunningViewController(nibName: "RunningViewController", bundle: nil)
        
        self.navigationController!.pushViewController(runningVC, animated: true)
    }
    
    @IBAction func curriculumButton(sender: AnyObject)
    {
        let curriculumVC = CurriculumViewController(nibName: "CurriculumViewController", bundle: nil)
        self.navigationController!.pushViewController(curriculumVC, animated: true)
    }
    
    @IBAction func seuCardButton(sender: AnyObject) {
        let seuCardVC = SeuCardViewController(nibName: "SeuCardViewController", bundle: nil)
        self.navigationController?.pushViewController(seuCardVC, animated: true)
    }
    
    @IBAction func nicButton(sender: AnyObject) {
        let nicVC = NicViewController(nibName: "NicViewController", bundle: nil)
        self.navigationController?.pushViewController(nicVC, animated: true)
    }
    
    @IBAction func academicNewsButton(sender: AnyObject)
    {
        let academicVC = AcademicViewController(nibName: "AcademicViewController", bundle: nil)
        self.navigationController!.pushViewController(academicVC, animated: true)
    }
    
    @IBAction func emptyRoomButton(sender: AnyObject)
    {
        let emptyRoomVC = EmptyRoomViewController(nibName: "EmptyRoomViewController", bundle: nil)
        
        self.navigationController!.pushViewController(emptyRoomVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
