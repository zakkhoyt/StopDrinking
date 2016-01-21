//
//  ZHSummaryView.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 1/21/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHSummaryView: UIView, ZHNibDefinable {

    @IBOutlet weak var view : UIView!
    @IBOutlet weak var avatarView: ZHAvatarView!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var user: ZHUserModel? = nil {
        didSet {
            if let user = user {
                avatarView.user = user
                avatarView.hidden = false
                summaryTextView.attributedText = summaryAttrString()
            } else {
                avatarView.user = nil
                avatarView.hidden = true
                summaryTextView.attributedText = NSAttributedString(string: "Open Stop Drinking to get started")
            }
        }
    }

    func summaryAttrString() -> NSAttributedString {
        if let user = user {

            let font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            var start = 0
            var length = 0
            var range = NSMakeRange(0, 0)
            let attrString = NSMutableAttributedString()
            
            let str1 = user.stringForDaysQuit() + ". "
            length = str1.characters.count
            range = NSMakeRange(start, length)
            attrString.appendAttributedString(NSAttributedString(string: str1))
            attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
            attrString.addAttribute(NSFontAttributeName, value: font, range: range)
            
            start += length
            let str2 = user.stringForDrinksMissed() + ". "
            length = str2.characters.count
            range = NSMakeRange(start, length)
            attrString.appendAttributedString(NSAttributedString(string: str2))
            attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
            attrString.addAttribute(NSFontAttributeName, value: font, range: range)

            
            start += length
            let str3 = user.stringForMoneyMissed() + ". "
            length = str3.characters.count
            range = NSMakeRange(start, length)
            attrString.appendAttributedString(NSAttributedString(string: str3))
            attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
            attrString.addAttribute(NSFontAttributeName, value: font, range: range)

            
            start += length
            let str4 = user.stringForCaloriesMissed() + "."
            length = str4.characters.count
            range = NSMakeRange(start, length)
            attrString.appendAttributedString(NSAttributedString(string: str4))
            attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
            attrString.addAttribute(NSFontAttributeName, value: font, range: range)

            return attrString
        } else {
            return NSAttributedString(string: "")
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
}
