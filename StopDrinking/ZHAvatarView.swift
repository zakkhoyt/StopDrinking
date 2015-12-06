//
//  ZHAvatarView.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHAvatarView: UIView {

    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    var user: ZHUserModel? = nil {
        didSet{
            configureView()
        }
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clearColor()
    }
    
    override func layoutSubviews() {
        configureView()
    }
    
    func configureForFlairClass(flairClass: String) {
        if flairClass.containsString("days") {
            shapeImageView.image = UIImage(named: "Circle")
        } else if flairClass.containsString("week") {
            shapeImageView.image = UIImage(named: "Circle")
        } else if flairClass.containsString("month") {
            shapeImageView.image = UIImage(named: "Star")
        } else if flairClass.containsString("year") {
            shapeImageView.image = UIImage(named: "Star")
        }
    }
    
    func configureView() {
        // Image
        let image = imageForDaysQuit()
        if let i = image {
            let im = i
            shapeImageView.image = im
        } else {
            print("no image returned for days quit")
        }
        
        
        // label
        let count = stringForDaysQuit()
        if let count = count {
            countLabel.text = "\(count)"
        } else {
            print("no string returned for days quit")
        }
        
        // label color
        let color = colorForDaysQuit()
        
        if let color = color {
            countLabel.textColor = color
        } else {
            print("no color returned for days quit")
        }
        
    }
    
    
    
    func stringForDaysQuit() -> String? {
        let days = user?.daysSinceStartDate()
        
        if let days = days {
            if days >= 0 && days <= 6 {
                return "\(days)d"
            } else if days >= 7 && days <= 30 {
                return "\(days / 7)w"
            } else if days >= 31 && days <= 364 {
                return "\(days / 31)m"
            } else if days >= 365 && days <= UInt(UINT32_MAX) {
                return "\(days / 365)y"
            }
        }
        
        return nil
    }
    
    func imageForDaysQuit() -> UIImage? {
        let days = user?.daysSinceStartDate()
        if let days = days {
            if days >= 0 && days <= 6 {
                return UIImage(named: "Circle")
            } else if days >= 7 && days <= 30 {
                return UIImage(named: "Circle")
            } else if days >= 31 && days <= 364 {
                return UIImage(named: "Star")
            } else if days >= 365 && days <= UInt(UINT32_MAX) {
                return UIImage(named: "Star")
            }
        }

        return nil
    }

    func colorForDaysQuit() -> UIColor? {
        let days = user?.daysSinceStartDate()
        if let days = days {
            if days >= 0 && days <= 6 {
                return UIColor.blackColor()
            } else if days >= 7 && days <= 30 {
                return colorForNumber(days / 7)
            } else if days >= 31 && days <= 364 {
                return colorForNumber(days / 31)
            } else if days >= 365 && days <= UInt(UINT32_MAX) {
                return UIColor.blackColor()
            }
        }
        
        return nil

    }
    

    
    func colorForNumber(number: UInt) -> UIColor? {
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
