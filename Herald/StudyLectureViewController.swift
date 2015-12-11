//
//  StudyLectureViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/12/11.
//  Copyright © 2015年 WangShuo. All rights reserved.
//

import UIKit

class StudyLectureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "学习讲座"
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
    
    //实验讲座查询
    @IBAction func labLectureButton(sender: AnyObject) {
        let labLectureSB = UIStoryboard(name: "LabLectureStoryboard", bundle: nil)
        let labLectureVC = labLectureSB.instantiateViewControllerWithIdentifier("LabLectureTabViewController") as UIViewController
        self.navigationController!.pushViewController(labLectureVC, animated: true)
    }
    
    //考试查询
    @IBAction func examButton(sender: AnyObject) {
        let examVC = ExamViewController(nibName: "ExamViewController", bundle: nil)
        self.navigationController?.pushViewController(examVC, animated: true)
    }
    
    //GPA成绩查询
    @IBAction func gradesButton(sender: AnyObject)
    {
        let gradesVC = GradeViewController(nibName: "GradeViewController", bundle: nil)
        self.navigationController!.pushViewController(gradesVC, animated: true)
    }
    
    //SRTP成绩查询
    @IBAction func srtpButton(sender: AnyObject)
    {
        let SRTPVC = SRTPViewController(nibName: "SRTPViewController", bundle: nil)
        self.navigationController!.pushViewController(SRTPVC, animated: true)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}