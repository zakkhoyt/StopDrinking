//
//  ZHUserModel.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHUserModel: NSObject {

    var startDate: NSDate? = nil
    var drinksPerDay: UInt? = nil
    var moneyPerDay: UInt? = nil
    var caloriesPerDrink: UInt? = nil
    var redditUsername: String? = nil
    var redditPassword: String? = nil
    var notificationTime: NSDate? = nil
    var redditAuthenticated: Bool = false;
    
    override init() {
        super.init()
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        super.init()
        startDate = aDecoder.decodeObjectForKey("startDate") as? NSDate
        drinksPerDay = aDecoder.decodeObjectForKey("drinksPerDay") as? UInt
        moneyPerDay = aDecoder.decodeObjectForKey("moneyPerDay") as? UInt
        caloriesPerDrink = aDecoder.decodeObjectForKey("caloriesPerDrink") as? UInt
        redditUsername = aDecoder.decodeObjectForKey("redditUsername") as? String
        redditPassword = aDecoder.decodeObjectForKey("redditPassword") as? String
        notificationTime = aDecoder.decodeObjectForKey("notificationTime") as? NSDate
    }
    

    func daysSinceStartDate() -> UInt? {
        if startDate == nil {
            return nil
        } else {
            let seconds = NSDate().timeIntervalSinceDate((startDate)!)
            let days = seconds / 60.0 / 60.0 / 24.0
            return UInt(days)
        }
    }


    func stringForDaysQuitWithOffset(offset: UInt) -> String{
        let days = daysSinceStartDate()
        
        if let days = days {
            return "\(days + offset) since your last drink. (" + stringForStartDate() + ")"
        } else {
            return ""
        }
        
    }
    
    func stringForDaysQuit() -> String{
        let days = daysSinceStartDate()
        
        if let days = days {
            return "\(days) since your last drink. (" + stringForStartDate() + ")"
        } else {
            return ""
        }
    }
    
    func stringForStartDate() -> String {
        if let startDate = startDate {
            let formatString = "MMMM dd, YYYY"
            let formatter = NSDateFormatter()
            formatter.timeZone = NSTimeZone.localTimeZone()
            formatter.dateFormat = formatString
            let dateString = formatter.stringFromDate(startDate)
            return dateString
        }
        return ""
    }
    
    func stringForDrinksMissed() -> String {
        let days = daysSinceStartDate()
        if let days = days {
            if let drinksPerDay = drinksPerDay {
                let drinks = drinksPerDay * days
                return "You've passed on \(drinks) drinks"
            }
        }
        return ""
    }

    func stringForMoneyMissed() -> String {
        let days = daysSinceStartDate()
        if let days = days {
            if let moneyPerDay = moneyPerDay {
                let money = moneyPerDay * days
                return "You've saved $\(money)"
            }
        }
        return ""
    }

    func stringForCaloriesMissed() -> String {
        let days = daysSinceStartDate()
        if let days = days {
            if let caloriesPerDrink = caloriesPerDrink {
                if let drinksPerDay = drinksPerDay {
                    let calories = days * drinksPerDay * caloriesPerDrink
                    let fat = calories / 3500
                    return "You've skipped drinking \(calories) Calories or \(fat) lbs of fat"
                }
            }
        }
        return ""
    }

    
    
    
    
    
    // Days quit
    func getDaysQuit() -> UInt {
        return 0
    }

    // View (star and colors)
    func getStarView() -> UIView {
        return UIView()
    }
    
//     Drinks saved
    func getDrinksSaved() -> UInt {
        return 0
    }
    // Money saved
    func getMoneySaved() -> UInt {
        return 0
    }
    
    // Calories saved
    func getCaloriesSaved() -> UInt {
        return 0
    }
    
}

extension ZHUserModel: NSSecureCoding {
    
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(startDate, forKey: "startDate")
        aCoder.encodeObject(drinksPerDay, forKey: "drinksPerDay")
        aCoder.encodeObject(moneyPerDay, forKey: "moneyPerDay")
        aCoder.encodeObject(caloriesPerDrink, forKey: "caloriesPerDrink")
        aCoder.encodeObject(redditUsername, forKey: "redditUsername")
        aCoder.encodeObject(redditPassword, forKey: "redditPassword")
        aCoder.encodeObject(notificationTime, forKey: "notificationTime")
    }
    
    
    @objc static func supportsSecureCoding() -> Bool {
        return true;
    }

    
    
}
