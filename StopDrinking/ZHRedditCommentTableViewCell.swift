//
//  ZHRedditCommentTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/24/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//
// // ** RKVotable
//  .upvotes
//  .downvotes
//  .score
//  .upvoted
//  .downvoted
//  .voted
//
// ** RKCreated
//  .created
//
// ** Display these
//  .Author "kilayo"
//  .body | .bodyHTML
//  .gilded 1
//  .replies.count - number of subcomments
//  .score
//  .created

//  Attributed text and taps:
//  http://stackoverflow.com/questions/19332283/detecting-taps-on-attributed-text-in-a-uitextview-in-ios
//




import UIKit

class ZHRedditCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var avatarView: ZHAvatarView!
    @IBOutlet weak var indentConstrint: NSLayoutConstraint!
    
    @IBOutlet weak var headerLayoutConstraint: NSLayoutConstraint!
    
    weak var treeView: RATreeView? = nil {
        didSet{
            
        }
    }
    
    var level: Int = 0{
        didSet{
            indentConstrint.constant = CGFloat(level) * 16
        }
    }
    
    var comment: RKComment? = nil {
        didSet {
            if let _ = comment {
                renderCellContents()
            }
        }
    }
    
    func renderCellContents() {
        
        
        if let comment = comment {
            if comment.replies.count > 0 {
                expandButton.hidden = false
                headerLayoutConstraint.constant = 0
            } else {
                expandButton.hidden = true
                headerLayoutConstraint.constant = -22
            }
            
            authorLabel.text = NSString(format: "%@", comment.author!) as String
            scoreLabel.text = NSString(format: "+%lu", comment.score) as String
            ageLabel.text = comment.created.stringRelativeTimeFromDate()
            
            
            let decodedHTML = ZHStringFormatter.bodyHTMLToAttributedString(comment.bodyHTML)
            commentTextView.attributedText = decodedHTML
            
            
            avatarView.configureForFlairClass(comment.authorFlairText)
            
        } else {
            
        }
        
        
    }
    
    

    func animateExpand(duration: NSTimeInterval) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.expandButton.setBackgroundImage(UIImage(named: "arrow_hollow"), forState: .Normal)
            self.expandButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        })
        
    }
    
    func animateCollapse(duration: NSTimeInterval) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.expandButton.setBackgroundImage(UIImage(named: "arrow"), forState: .Normal)
            self.expandButton.transform = CGAffineTransformIdentity
        })
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
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
