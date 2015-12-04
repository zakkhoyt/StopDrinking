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


    func setupAppearance() {
        
        
        
//        // UIView (this is what controls the color of the back button arrow)
//        [[UIView appearance] setTintColor:[UIColor zhTintColor]];
//        //    [[UIView appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor zhBackgroundColor]];
//        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] setTintColor:[UIColor zhBackgroundColor]];
//        
//        // UILabel
//        [[UILabel appearance] setTextColor:[UIColor zhGreenColor]];
//        
//        // Navigation bar
//        NSDictionary *navBarAttributes = @{NSForegroundColorAttributeName : [UIColor zhBackgroundColor]};
//        [[UINavigationBar appearance] setTitleTextAttributes:navBarAttributes];
//        [[UINavigationBar appearance] setBarTintColor:[UIColor zhTintColor]];
//        [[UINavigationBar appearance] setTintColor:[UIColor zhBackgroundColor]];
//        // The nav bar back button
//        [[UIBarButtonItem appearance] setTitleTextAttributes:navBarAttributes forState:UIControlStateNormal];
//        
//        // Tabbar
//        [[UITabBar appearance] setBarTintColor:[UIColor zhTintColor]];
//        [[UITabBar appearance] setTintColor:[UIColor zhBackgroundColor]];
//        
//        // TabbarItem
//        NSDictionary *tabBarAttributes = @{NSForegroundColorAttributeName : [UIColor zhBackgroundColor]};
//        [[UITabBarItem appearance] setTitleTextAttributes:tabBarAttributes forState:UIControlStateNormal];
//        
//        // Segmented control
//        NSDictionary *segmentAttributes = @{NSForegroundColorAttributeName : [UIColor zhTintColor],
//            NSStrokeColorAttributeName : [UIColor zhBackgroundColor]};
//        [[UISegmentedControl appearance] setTitleTextAttributes:segmentAttributes forState:UIControlStateNormal];
//        
//        // Toolbar
//        [[UIToolbar appearance] setBarTintColor:[UIColor zhBackgroundColor]];
//        [[UIToolbar appearance] setTintColor:[UIColor zhTintColor]];
//        
//        // Text controls
//        [[UITextView appearance] setTextColor:[UIColor zhDarkTextColor]];
//        [[UITextView appearance] setBackgroundColor:[UIColor zhBackgroundColor]];
//        
//        [[UITextField appearance] setTextColor:[UIColor zhDarkTextColor]];
//        [[UITextField appearance] setBackgroundColor:[UIColor zhBackgroundColor]];
//        
//        [[UITableView appearance] setBackgroundColor:[UIColor zhBackgroundColor]];
//        [[UITableViewCell appearance] setBackgroundColor:[UIColor zhBackgroundColor]];
//        
//        [[UICollectionView appearance] setBackgroundColor:[UIColor zhBackgroundColor]];
//        [[UICollectionViewCell appearance]setBackgroundColor:[UIColor zhBackgroundColor]];
//        
//        [[UIButton appearance] setTintColor:[UIColor zhTintColor]];
//        [[UIButton appearance] setTitleColor:[UIColor zhTintColor] forState:UIControlStateNormal];
//        
//        [[UISearchBar appearance] setTintColor:[UIColor zhTintColor]];
    
        
//        let zhBackgroundColor = UIColor.darkGrayColor()
//        let zhTintColor = UIColor.yellowColor()
//        let zhTextColor = UIColor.whiteColor()
//        
//        UIView.appearance().tintColor = zhTintColor
////        UIView.appearanceWhenContainedInInstancesOfClasses([UINavigationBar]).tintColor = zhBackgroundColor
//        
//        UILabel.appearance().textColor = zhTextColor
//        
//        let navBarAttr = [NSForegroundColorAttributeName: zhBackgroundColor]
//        UINavigationBar.appearance().titleTextAttributes = navBarAttr
//        UINavigationBar.appearance().barTintColor = zhTintColor
//        UINavigationBar.appearance().tintColor = zhBackgroundColor
//        
////        UIBarButtonItem.appearance().titleTextAttributesForState(UIControlState.Normal) = navBarAttr
        
        

        
        let attr = [NSForegroundColorAttributeName: UIColor.yellowColor()]
        UINavigationBar.appearance().titleTextAttributes = attr
        UINavigationBar.appearance().barTintColor = UIColor.darkGrayColor()
        UINavigationBar.appearance().tintColor = UIColor.yellowColor()
        UIBarButtonItem.appearance().setTitleTextAttributes(attr, forState: UIControlState.Normal)
        
        UIToolbar.appearance().barTintColor = UIColor.darkGrayColor()
        UIToolbar.appearance().tintColor = UIColor.yellowColor()
        
//        UIView.appearance().backgroundColor = UIColor.darkGrayColor()
        UITableViewCell.appearance().backgroundColor = UIColor.darkGrayColor()
        UITableView.appearance().backgroundColor = UIColor.darkGrayColor()
    }
}
























