//
//  LibNavViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-5.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class LibNavViewController: UIViewController {

    @IBOutlet var jlhButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "本馆导航"
        
        let color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
    }


    @IBAction func clickJLHButton(sender: AnyObject) {
        
        let LibJLHNavVC = LibJLHNavViewController(nibName: "LibJLHNavViewController", bundle: nil)
        self.navigationController!.pushViewController(LibJLHNavVC, animated: true)
    }

    

    @IBAction func clickSPLButton(sender: AnyObject) {
        
        let LibSPLNavVC = LibSPLNavViewController(nibName: "LibSPLNavViewController", bundle: nil)
        self.navigationController!.pushViewController(LibSPLNavVC, animated: true)

    }

}
