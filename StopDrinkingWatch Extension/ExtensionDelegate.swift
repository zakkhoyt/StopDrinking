//
//  ExtensionDelegate.swift
//  StopDrinkingWatch Extension
//
//  Created by Zakk Hoyt on 1/21/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        
        let user = ZHUserDefaults.sharedInstance.currentUser()
        if let user = user {
            //            //            summaryView.user = user
            //            //            completionHandler(NCUpdateResult.NewData)
            //            summaryLabel.setText(user.stringForDaysQuit())
            print("User found: " + user.stringForDaysQuit())
        } else {
            //            //            summaryView.user = nil
            //            //            completionHandler(NCUpdateResult.NoData)
            //            summaryLabel.setText("No user yet")
            print("no user found")
        }
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

}
