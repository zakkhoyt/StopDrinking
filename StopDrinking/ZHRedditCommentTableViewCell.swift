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
    @IBOutlet weak var avatarContainerView: UIView!
    @IBOutlet weak var indentConstrint: NSLayoutConstraint!
    var avatarView: ZHAvatarView!
    
    @IBOutlet weak var headerLayoutConstraint: NSLayoutConstraint!
    
    weak var treeView: RATreeView? = nil {
        didSet{
            
        }
    }
    
    var expanded: Bool = false {
        didSet{
            renderCellContents()
        }
    }
    
    var level: Int = 0{
        didSet{
            indentConstrint.constant = CGFloat(level) * 16
        }
    }

    var model: ZHRedditThreadCellModel? = nil {
        didSet {
            renderCellContents()
        }
    }
    
    func renderCellContents() {
        
        
        if model?.comment.replies.count > 0 {
            expandButton.hidden = false
            headerLayoutConstraint.constant = 0
        } else {
            expandButton.hidden = true
            headerLayoutConstraint.constant = -22
        }
        
        authorLabel.text = NSString(format: "%@", (model?.comment.author)!) as String
        scoreLabel.text = NSString(format: "+%lu", (model?.comment.score)!) as String
        ageLabel.text = model?.comment.created.stringRelativeTimeFromDate()

        commentTextView.text = model?.comment.body
//        let parser = NSAttributedStringMarkdownParser()
//        let attrString = parser.attributedStringFromMarkdownString(model?.comment.body)
//        commentTextView.attributedText = attrString

        
        avatarContainerView.hidden = true
        
        if model?.expanded == false {
            self.expandButton.setBackgroundImage(UIImage(named: "arrow"), forState: .Normal)
            self.expandButton.transform = CGAffineTransformIdentity
        } else {
            self.expandButton.setBackgroundImage(UIImage(named: "arrow_hollow"), forState: .Normal)
            self.expandButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        }

    }
    
    

    @IBAction func expandButtonTouchUpInside(sender: AnyObject) {
        
        if model?.expanded == false {
            model?.expanded = true
            
            let item = treeView!.itemForCell(self)
            treeView!.expandRowForItem(item)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.expandButton.setBackgroundImage(UIImage(named: "arrow_hollow"), forState: .Normal)
                self.expandButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            })
        
        } else {
            model?.expanded = false
            
            let item = treeView!.itemForCell(self)
            treeView!.collapseRowForItem(item)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.expandButton.setBackgroundImage(UIImage(named: "arrow"), forState: .Normal)
                self.expandButton.transform = CGAffineTransformIdentity
            })

        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        
        avatarView = NSBundle.mainBundle().loadNibNamed("ZHAvatarView", owner: self, options: nil).first as? ZHAvatarView
        avatarView.frame = avatarContainerView.bounds
        avatarContainerView.addSubview(avatarView!)

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("asdf")
//    }
    
}


extension ZHRedditCommentTableViewCell: UITextViewDelegate {
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
}
