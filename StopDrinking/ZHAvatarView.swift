//
//  ZHAvatarView.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//
// 1-6 days circle + smiley
// 7-13 days circle + green weeks (1)
// 14-20 days circle + red weeks (2)
// 21-27 dyas circel + blue weeks (3)
// 28-30 days circle + purple weeks(4)

// 31-61 star + green mo (1)
// 62-92 star + red
//

// 365 + star + :)
//
//
//


import UIKit



class ZHAvatarView: UIView, ZHNibDefinable {
    
    @IBOutlet weak var view : UIView!
    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    var user: ZHUserModel? = nil {
        didSet{
            configureView()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromXib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        backgroundColor = .clearColor()
        addSubview(view)
    }
    
    func loadViewFromXib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        return view
    }
    

    override func layoutSubviews() {
        configureView()
    }
    
    func configureForFlairClass(authorFlairText: String?) {
        if let authorFlairText = authorFlairText {
            hidden = false
            let sub = authorFlairText.componentsSeparatedByString(" ")
            if sub.count > 0 {
                let days = UInt(sub.first!)
                if let days = days {
                    configureViewForDaysQuit(days)
                }
            }
        } else {
            hidden = true
        }
    }
    
    func configureView() {
        let days = user?.daysSinceStartDate()
        if let days = days {
            configureViewForDaysQuit(days)
        }
    }
    
    func configureViewForDaysQuit(days: UInt) {
        // Image
        let image = imageForDaysQuit(days)
        if let i = image {
            let im = i
            shapeImageView.image = im
        } else {
            print("no image returned for days quit")
        }
        
        
        // label
        let count = stringForDaysQuit(days)
        if let count = count {
            countLabel.text = "\(count)"
        } else {
            print("no string returned for days quit")
        }
        
        // label color
        let color = colorForDaysQuit(days)
        if let color = color {
            countLabel.textColor = color
        } else {
            print("no color returned for days quit")
        }
        
        if bounds.size.height > 44 {
            countLabel.font = UIFont.boldSystemFontOfSize(20)
        } else {
            countLabel.font = UIFont.boldSystemFontOfSize(10)
        }
        
    }
    
    
    
    
    func stringForDaysQuit(days: UInt) -> String? {
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
    
    func imageForDaysQuit(days: UInt) -> UIImage? {
        if days >= 0 && days <= 30 {
            return UIImage(named: "circle")
        } else if days >= 31 {
            return UIImage(named: "star")
        }
        return nil
    }
    
    func colorForDaysQuit(days: UInt) -> UIColor? {
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



