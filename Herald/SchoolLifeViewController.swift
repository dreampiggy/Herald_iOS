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
        let color = UIColor(red: 73/255, green: 185/255, blue: 161/255, alpha: 1)
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
    
    @IBAction func nicSeuButton(sender: AnyObject) {
        let nicSeuSB = UIStoryboard(name: "NicSeuStoryboard", bundle: nil)
        let nicSeuVC = nicSeuSB.instantiateViewControllerWithIdentifier("NicSeuTabViewController") as UIViewController
        self.navigationController!.pushViewController(nicSeuVC, animated: true)
    }
    
    @IBAction func labLectureButton(sender: AnyObject) {
        let labLectureSB = UIStoryboard(name: "LabLectureStoryboard", bundle: nil)
        let labLectureVC = labLectureSB.instantiateViewControllerWithIdentifier("LabLectureTabViewController") as UIViewController
        self.navigationController!.pushViewController(labLectureVC, animated: true)
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
    
    @IBAction func gradesButton(sender: AnyObject)
    {
        let gradesVC = GradeViewController(nibName: "GradeViewController", bundle: nil)
        self.navigationController!.pushViewController(gradesVC, animated: true)
    }
    
    
    @IBAction func srtpButton(sender: AnyObject)
    {
        let SRTPVC = SRTPViewController(nibName: "SRTPViewController", bundle: nil)
        self.navigationController!.pushViewController(SRTPVC, animated: true)
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
