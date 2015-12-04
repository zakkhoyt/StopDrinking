//
//  ZHRedditCommentTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/24/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHRedditCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!

    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var indentConstrint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowConstraint: NSLayoutConstraint!
    
    
//    override var selected: Bool {
//        didSet {
////            print("selected: " + selected ? "true" : "false")
//            if selected == true {
//                print("selected")
//            } else {
//                print("deselected")
//            }
//        }
//    }
    
    var expanded: Bool = false {
        didSet{
            renderCellContents()
        }
    }
    
    var level: Int = 0{
        didSet{
            indentConstrint.constant = 30 + CGFloat(level-2) * 16
            arrowConstraint.constant = 30 + CGFloat(level-2) * 16
        }
    }
    
    var comment: RKComment? = nil {
        didSet{
            renderCellContents()
        }
    }
    

    
    func renderCellContents() {
        commentTextView.text = comment?.body
        if comment?.replies.count > 0 && expanded == true {
            arrowImageView.alpha = 1.0
//            UIView .animateWithDuration(0.3, animations: { () -> Void in
                self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
//            })
        } else if comment?.replies.count > 0 && expanded == false {
            arrowImageView.alpha = 1.0
//            UIView .animateWithDuration(0.3, animations: { () -> Void in
                self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(0))
//            })
        } else {
            arrowImageView.alpha = 0.3
//            UIView .animateWithDuration(0.3, animations: { () -> Void in
                self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(0))
//            })

        }
        
        userLabel.text = NSString(format: "%@", comment!.author) as String
        votesLabel.text = NSString(format: "+%lu", comment!.score) as String
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


extension ZHRedditCommentTableViewCell: UITextViewDelegate {
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
}
