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
    
    var firstName: String? = nil
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        startDate = aDecoder.decodeObjectForKey("startDate") as? NSDate
        drinksPerDay = aDecoder.decodeObjectForKey("drinksPerDay") as? UInt
        moneyPerDay = aDecoder.decodeObjectForKey("moneyPerDay") as? UInt
        caloriesPerDrink = aDecoder.decodeObjectForKey("caloriesPerDrink") as? UInt
        redditUsername = aDecoder.decodeObjectForKey("redditUsername") as? String
        redditPassword = aDecoder.decodeObjectForKey("redditPassword") as? String
        firstName = aDecoder.decodeObjectForKey("firstName") as? String
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

    

    func summary() -> String {
        if let fn = firstName {
            return "Here is a summary for you, " + fn
        } else {
            return "Here is a summary for you"
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
                return "Passed on \(drinks) drinks"
            }
        }
        return ""
    }

    func stringForMoneyMissed() -> String {
        let days = daysSinceStartDate()
        if let days = days {
            if let moneyPerDay = moneyPerDay {
                let money = moneyPerDay * days
                return "Saved $\(money)"
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
                    return "Not consumed $\(calories)"
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
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(startDate, forKey: "startDate")
        aCoder.encodeObject(drinksPerDay, forKey: "drinksPerDay")
        aCoder.encodeObject(moneyPerDay, forKey: "moneyPerDay")
        aCoder.encodeObject(caloriesPerDrink, forKey: "caloriesPerDrink")
        aCoder.encodeObject(redditUsername, forKey: "redditUsername")
        aCoder.encodeObject(redditPassword, forKey: "redditPassword")
        aCoder.encodeObject(firstName, forKey: "firstName")
    }
    
    
    static func supportsSecureCoding() -> Bool {
        return true;
    }

    
    
}
