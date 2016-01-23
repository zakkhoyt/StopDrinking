//
//  ZHAvatar.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 1/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHAvatar {
    class func stringForDaysQuit(days: UInt) -> String? {
        if days >= 0 && days <= 6 {
            return "\(days)d"
        } else if days >= 7 && days <= 30 {
            return "\(days / 7)w"
        } else if days >= 31 && days <= 364 {
            return "\(days / 31)m"
        } else if days >= 365 && days <= UInt(UINT32_MAX) {
            return "\(days / 365)y"
        }
        return nil
    }
    
    class func imageForDaysQuit(days: UInt) -> UIImage? {
        if days >= 0 && days <= 30 {
            return UIImage(named: "circle")
        } else if days >= 31 {
            return UIImage(named: "star")
        }
        return nil
    }
    
    class func colorForDaysQuit(days: UInt) -> UIColor? {
        if days >= 0 && days <= 6 {
            return UIColor.blackColor()
        } else if days >= 7 && days <= 30 {
            return colorForNumber(days / 7)
        } else if days >= 31 && days <= 364 {
            return colorForNumber(days / 31)
        } else if days >= 365 && days <= UInt(UINT32_MAX) {
            return UIColor.blackColor()
        }
        return nil
    }
    
    class func colorForNumber(number: UInt) -> UIColor? {
        switch number {
        case 1:
            return UIColor(colorLiteralRed: 0.0, green: 0.7, blue: 0.0, alpha: 1.0)
        case 2:
            return UIColor(colorLiteralRed: 0.7, green: 0.0, blue: 0.0, alpha: 1.0)
        case 3:
            return UIColor.blueColor()
        case 4:
            return UIColor.purpleColor()
        default:
            return UIColor.blackColor()
        }
    }
}