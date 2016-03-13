//
//  AppDelegate.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 2/14/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Parse
        // Set applicationId and server based on the values in the Heroku settings.
        // clientKey is not used on Parse open source unless explicitly configured
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "instaPicsjanlcw7i4r49r4f"
                configuration.clientKey = "HGJN%$&%$guyiti6tnu6U%&fturdsd"
                configuration.server = "https://agile-tundra-85978.herokuapp.com/Parse"
            })
        )
        
        
        if PFUser.currentUser() != nil {
            print("Current user detected: \(PFUser.currentUser()!.username)")
            let vc = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            window?.rootViewController = vc
            
        } else {
            print("Please log in")
            let vc = storyboard.instantiateViewControllerWithIdentifier("loginView") as UIViewController
            window?.rootViewController = vc
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToHomeView", name: goToHomeViewNotification, object: nil)
        
        
        return true
    }
    
    func userDidLogout() {
        //  print("Notification received")
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginView") as UIViewController
        window?.rootViewController = vc
    }
    
    //    func goToHomeView() {
    //        //  print("Notification received")
    //        let vc2 = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
    //        window?.rootViewController = vc2
    //    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

