//
//  CenterViewController.swift
//  先声
//
//  Created by Wangshuo on 14-8-1.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController ,UIScrollViewDelegate,HttpProtocol{

    
    var scrollView:UIScrollView!
    var pageControl:UIPageControl!
    var imageView:UIImageView!
    var eHttp:HttpController = HttpController()
    var imageView1:UIImageView?
    var imageView2:UIImageView?
    var imageView3:UIImageView?
    var imageView4:UIImageView?
    var imageView5:UIImageView?
    var screenSize:CGSize = UIScreen.mainScreen().bounds.size
    
    let imageCache:SDImageCache = SDImageCache()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    
        self.navigationItem.title = "先声"
        self.setupLeftMenuButton()
        
        self.setupScrollPic()
        
//        self.eHttp.delegate = self
//        
//        self.eHttp.requestFromURLAF("http://herald.seu.edu.cn/EzHerald/picturejson/", tag: "images")
//        
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
    
//    func didReceiveArrayResults(results: NSArray, tag: String)
//    {
//        if tag == "images"
//        {
//            var imageArray :[UIImageView!] = [self.imageView1,self.imageView2,self.imageView3,self.imageView4,self.imageView5]
//            
//            var count:CGFloat = 0
//            for i in 0..<5
//            {
//                
//                let xPosition  = self.screenSize.width * count
//                imageArray[i] = UIImageView(frame: CGRectMake(xPosition, -64, self.screenSize.width, self.scrollView!.frame.height))
//                
//                let urlDictionary: NSDictionary = results.objectAtIndex(i) as NSDictionary
//    
//                let nsurl = NSURL(string: urlDictionary.objectForKey("url") as String )
//                
//                imageArray[i].sd_setImageWithURL(nsurl, placeholderImage: UIImage(named: "HeraldLogo.png"))
//                
//                // self.imageCache.storeImage(imageArray[i].image, forKey: String(i), toDisk: true)
//                
//                self.scrollView!.addSubview(imageArray[i])
//                
//                count = count + 1
//            }
//        }
//    }
    
    func setupScrollPic()
    {
        var color = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        self.scrollView = UIScrollView(frame: CGRectMake(0, 64, self.screenSize.width, self.screenSize.height/2.5))
        self.scrollView.delegate = self
        
        var scrollSize:CGSize = CGSizeMake(self.screenSize.width * 5, 0)
        
        self.scrollView.contentSize = scrollSize
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.pagingEnabled = true
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.bounces = false
        
        var pageControlSize:CGSize = CGSizeMake(120, 40)
        
        var framePageControl:CGRect = CGRectMake((self.scrollView.frame.width-pageControlSize.width)/2, self.screenSize.height/2.25, pageControlSize.width, pageControlSize.height)
        
        self.pageControl = UIPageControl(frame: framePageControl)
        self.pageControl.hidesForSinglePage = true
        self.pageControl.userInteractionEnabled = false
        self.pageControl.backgroundColor = UIColor.clearColor()
        self.pageControl.numberOfPages = 5
        
        
        var imageArray :[UIImageView!] = [self.imageView1,self.imageView2,self.imageView3,self.imageView4,self.imageView5]

        var count:CGFloat = 0
        for i in 0..<5
        {
            var nameCounter = String(i + 1)
            var imageName:String = "image" + nameCounter + ".png"
            //get the image1.png to image5.png
            let xPosition  = self.screenSize.width * count
            imageArray[i] = UIImageView(frame: CGRectMake(xPosition, -64, self.screenSize.width, self.scrollView!.frame.height))
            imageArray[i].image = UIImage(named: imageName)
            self.scrollView!.addSubview(imageArray[i])
            count = count + 1
        }
        
//        var homePageView = UIImageView(frame: CGRectMake(0, 64, self.screenSize.width, self.scrollView!.frame.height))
//        homePageView.image = UIImage(named: "image1.png")
//        homePageView.userInteractionEnabled = true
        
        
        self.imageView = UIImageView(frame: CGRectMake(0, 64 + self.scrollView.frame.height, self.screenSize.width, self.screenSize.height - 64 - self.scrollView.frame.height))
        self.imageView.image = UIImage(named: "MainPagePic.jpg")
        self.imageView.userInteractionEnabled = true
        
//        self.view.addSubview(homePageView)
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
        self.view.addSubview(self.imageView)
        
        var schoolLifeButton = UIButton(frame: CGRectMake(0, 0, self.imageView.frame.width / 2, self.imageView.frame.height / 2))
        schoolLifeButton.addTarget(self, action: Selector("schoolLifeClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.imageView.addSubview(schoolLifeButton)
        
        var libraryButton = UIButton(frame: CGRectMake(self.imageView.frame.width / 2, 0, self.imageView.frame.width / 2, self.imageView.frame.height / 2))
        libraryButton.addTarget(self, action: Selector("libraryClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.imageView.addSubview(libraryButton)

        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!)
    {
        
        let index = fabs(self.scrollView!.contentOffset.x) / self.screenSize.width
        
        let i = Int(index)
        
        self.pageControl.currentPage = i
        
    }
    
    func schoolLifeClicked()
    {
        var mydrawerController = self.mm_drawerController
        let schoolLifeViewController:SchoolLifeViewController = SchoolLifeViewController(nibName: "SchoolLifeViewController", bundle: nil)
        let navSchoolLifeViewController = CommonNavViewController(rootViewController: schoolLifeViewController)

        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:{(complete) in
            if complete{
                mydrawerController.setCenterViewController(navSchoolLifeViewController, withCloseAnimation: true, completion: nil)
                mydrawerController.closeDrawerAnimated(true, completion:nil)
            }
        })
    }

    func libraryClicked()
    {
        var mydrawerController = self.mm_drawerController
        let LibraryVC = LibraryViewController(nibName: "LibraryViewController", bundle: nil)
        let navLibraryViewController = CommonNavViewController(rootViewController: LibraryVC)
    
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: {(complete) in
            if complete{
                mydrawerController.setCenterViewController(navLibraryViewController, withCloseAnimation: true, completion: nil)
                mydrawerController.closeDrawerAnimated(true, completion:nil)
            }
        })
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
