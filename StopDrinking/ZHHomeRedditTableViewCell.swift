//
//  ZHHomeRedditTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHHomeRedditTableViewCell: UITableViewCell  {
    
    
    
    @IBOutlet weak var postTextView: UITextView!
    var index: UInt = 0
    var post: RKLink? = nil{
        didSet{
            let attrString = NSMutableAttributedString()
            var insertPoint: Int = 0
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Left
            
            
            
//            let attr0 = [NSParagraphStyleAttributeName : paragraph,
//                NSForegroundColorAttributeName : UIColor.blackColor(),
//                NSFontAttributeName: UIFont.boldSystemFontOfSize(28)]
//            
//            let str0 = NSString(format: "%lu.) ", index)
//            attrString.appendAttributedString(NSAttributedString(string: str0))
//            attrString.setAttributes(attr0, range: NSMakeRange(insertPoint, str0.length))
//            insertPoint += str0.length
            
            
            let attr1 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.whiteColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(22)]
            
            let str1 = NSString(format: "%@\n", post!.title)
            attrString.appendAttributedString(NSAttributedString(string: str1 as String))
            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
            insertPoint += str1.length
            
//            let attr2 = [NSParagraphStyleAttributeName : paragraph,
//                NSForegroundColorAttributeName : UIColor.darkTextColor(),
//                NSFontAttributeName: UIFont.systemFontOfSize(15)]
//            let str2 = NSString(format: "\n%@\n", post!.selfText)
//            attrString.appendAttributedString(NSAttributedString(string: str2))
//            attrString.setAttributes(attr2, range: NSMakeRange(insertPoint, str2.length))
//            insertPoint += str2.length
            
            let attr3 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.lightGrayColor(),
                NSFontAttributeName: UIFont.italicSystemFontOfSize(18)]
            
            let str3 = NSString(format: "\n-%@\n", post!.author)
            attrString.appendAttributedString(NSAttributedString(string: str3 as String))
            attrString.setAttributes(attr3, range: NSMakeRange(insertPoint, str3.length))
            insertPoint += str3.length
            
            postTextView.attributedText = attrString
            
//            let size = postTextView.sizeThatFits(CGSizeMake(self.bounds.width, 100000))
//            println("size: " + NSStringFromCGSize(size))
//            
            UIView.animateWithDuration(3.0, animations: { () -> Void in
                self.layoutIfNeeded()
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


