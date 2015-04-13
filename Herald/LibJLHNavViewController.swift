//
//  LibJLHNavViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-8.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class LibJLHNavViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var imageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let scrollViewSize = CGSizeMake(726, 476)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 726, 476))
        self.imageView?.image = UIImage(named: "jlhLib1_726_476.jpg")
        
        self.scrollView.addSubview(self.imageView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func firstFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(726, 476)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 726, 476))
        self.imageView?.image = UIImage(named: "jlhLib1_726_476.jpg")
        
        self.scrollView.addSubview(self.imageView!)
        
    }
    
    
    
    @IBAction func secondFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(733, 600)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 733, 600))
        self.imageView?.image = UIImage(named: "jlhLib2_733_600.jpg")
        
        self.scrollView.addSubview(self.imageView!)
    }
    
    
    @IBAction func thirdFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(760, 610)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 760, 610))
        self.imageView?.image = UIImage(named: "jlhLib3_760_610.jpg")
        
        self.scrollView.addSubview(self.imageView!)
    }
    
    
    @IBAction func fourthFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(740, 516)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 740, 516))
        self.imageView?.image = UIImage(named: "jlhLib4_740_516.jpg")
        
        self.scrollView.addSubview(self.imageView!)
    }
    
    
    
    @IBAction func fifthFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(740, 437)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 740, 437))
        self.imageView?.image = UIImage(named: "jlhLib5_740_437.jpg")
        
        self.scrollView.addSubview(self.imageView!)
    }

}
