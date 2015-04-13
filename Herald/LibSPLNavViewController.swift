//
//  LibSPLNavViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-8.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class LibSPLNavViewController: UIViewController {

    
    @IBOutlet var scrollView: UIScrollView!
    
    
    var imageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let scrollViewSize = CGSizeMake(740, 820)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 740, 820))
        self.imageView?.image = UIImage(named: "splLib1_740_820.jpg")
        
        self.scrollView.addSubview(self.imageView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func firstFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(740, 820)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 740, 820))
        self.imageView?.image = UIImage(named: "splLib1_740_820.jpg")
        
        self.scrollView.addSubview(self.imageView!)
    }
    
    
    
    @IBAction func secondFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(740, 710)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 740, 710))
        self.imageView?.image = UIImage(named: "splLib2_740_710.jpg")
        
        self.scrollView.addSubview(self.imageView!)
    }
    
    
    
    @IBAction func thirdFloorClicked(sender: AnyObject) {
        
        self.imageView?.removeFromSuperview()
        
        let scrollViewSize = CGSizeMake(740, 640)
        self.scrollView.contentSize = scrollViewSize
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 740, 640))
        self.imageView?.image = UIImage(named: "splLib3_740_640.jpg")
        
        self.scrollView.addSubview(self.imageView!)
    }

}
