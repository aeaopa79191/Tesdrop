//
//  customizeTabBar.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class customizeTabBar: UITabBarController, UITabBarControllerDelegate {

    var button: UIButton = UIButton()
    var isHighLighted:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        let middleImage:UIImage = UIImage(named:"mapButton")!
        let highlightedMiddleImage:UIImage = UIImage(named:"mapButton_highlighted")!
        
        addCenterButtonWithImage(middleImage, highlightImage: highlightedMiddleImage)
        self.tabBar.barTintColor = UIColor.blackColor()
        
        //changeTabToMiddleTab(button)
    }
    
    //MARK: TABBAR DELEAGATE
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if !viewController.isKindOfClass(Contribute)
        {
            button.userInteractionEnabled = true
            button.highlighted = false
            button.selected = false
            isHighLighted = false
        }
        else {
            button.userInteractionEnabled = false
        }
    }
    
//    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//        if  self.selectedViewController == viewController {
//            print("Select one controller in tabbar twice")
//            return false
//        }
//        return true
//    }
    
    //MARK: MIDDLE TAB BAR HANDLER
    func addCenterButtonWithImage(buttonImage: UIImage, highlightImage:UIImage?)
    {
        
        let frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
        button = UIButton(frame: frame)
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.setBackgroundImage(highlightImage, forState: UIControlState.Highlighted)
        
        let heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center;
        }
        else
        {
            var center:CGPoint = self.tabBar.center;
            center.y = center.y - heightDifference/2.0;
            button.center = center;
        }
        
        button.addTarget(self, action: "changeTabToMiddleTab:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    
    // Go to middle tap
    func changeTabToMiddleTab(sender:UIButton)
    {
        let selectedIndex = Int(self.viewControllers!.count/2)
        self.selectedIndex = selectedIndex
        self.selectedViewController = (self.viewControllers as [AnyObject]?)?[selectedIndex] as? UIViewController
        dispatch_async(dispatch_get_main_queue(), {
            
            if self.isHighLighted == false{
                sender.highlighted = true;
                self.isHighLighted = true
            }else{
                sender.highlighted = false;
                self.isHighLighted = false
            }
        });
        
        sender.userInteractionEnabled = false
    }

}
