
//
//  NotificationScheduler.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit



class ZHNotificationScheduler: NSObject {
    class func scheduleNotifications(){
        // Ask for permission
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert, UIUserNotificationType.Badge], categories: nil))
        
        unscheduleNotifications()
        
        let user = ZHUserDefaults.sharedInstance.currentUser()
        if user == nil {
            print("Error: Can't schedule notification because user is nil")
            return
        }
        
        // Schedule daily notification for next 30 days
        for day in 0...30 {
            // schedule notification for tomorrow
            let notification = UILocalNotification()
            notification.timeZone = NSTimeZone.defaultTimeZone()
            
            let futureDate = dateForDaysFromNow(day)
            notification.fireDate = futureDate
            
            notification.alertBody = user?.stringForDaysQuitWithOffset(UInt(day))
            
            let daysSinceStartDate = user?.daysSinceStartDate()!
            notification.applicationIconBadgeNumber = Int(daysSinceStartDate!)
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)

            print("fireDate: " + notification.fireDate!.description)
            print("alert: " + notification.alertBody!)
            print("inspect notification")
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = 99
    }
    
    class func unscheduleNotifications() {
        // Cancel all previously scheduled notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        print("Unscheduled all notifications")
    }
    
    class func dateForDaysFromNow(daysfromNow: Int) -> NSDate {
        
        let user = ZHUserDefaults.sharedInstance.currentUser()
        if user == nil {
            print("Error: Can't schedule notification because user is nil")
            return NSDate()
        }

        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components(([.Hour, .Minute]), fromDate: (user?.notificationTime!)!)
        let hour = comp.hour
        let minute = comp.minute
//        let day = comp.day
        
        let now = NSDate()
        let tomorrowComponents = NSDateComponents()
        tomorrowComponents.day = daysfromNow;
        
        
        
        let tomorrow = calendar.dateByAddingComponents(tomorrowComponents, toDate: now, options: [])
        
        let tomorrowMorningComponents = calendar.components([.Era, .Year, .Month, .Day], fromDate: tomorrow!)
        tomorrowMorningComponents.hour = hour
        tomorrowMorningComponents.minute = minute
        
        let tomorrowMorning = calendar.dateFromComponents(tomorrowMorningComponents)
        return tomorrowMorning!
    }
}
