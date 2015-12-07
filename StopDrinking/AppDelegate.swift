//
//  AppDelegate.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        setupAppearance()
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return true
    }

    func setupAppearance() {
         let attr = [NSForegroundColorAttributeName: UIColor.yellowColor()]
        UINavigationBar.appearance().titleTextAttributes = attr
        UINavigationBar.appearance().barTintColor = UIColor.darkGrayColor()
        UINavigationBar.appearance().tintColor = UIColor.yellowColor()
        UIBarButtonItem.appearance().setTitleTextAttributes(attr, forState: UIControlState.Normal)
        
        UIToolbar.appearance().barTintColor = UIColor.darkGrayColor()
        UIToolbar.appearance().tintColor = UIColor.yellowColor()
        
        UITableViewCell.appearance().backgroundColor = UIColor.darkGrayColor()
        UITableView.appearance().backgroundColor = UIColor.darkGrayColor()
    }
}
























