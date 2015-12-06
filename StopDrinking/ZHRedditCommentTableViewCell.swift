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
    
    var comment: RKComment? = nil {
        didSet{

            renderCellContents()
        }
    }
    
    func renderCellContents() {
        
        
        if comment?.replies.count > 0 {
            expandButton.hidden = false
            headerLayoutConstraint.constant = 0
        } else {
            expandButton.hidden = true
            headerLayoutConstraint.constant = -22
        }
        
        authorLabel.text = NSString(format: "%@", comment!.author) as String
        scoreLabel.text = NSString(format: "+%lu", comment!.score) as String
        ageLabel.text = comment?.created.stringRelativeTimeFromDate()
        commentTextView.text = comment?.body
        
        avatarContainerView.hidden = true
        
////        avatarView.configureForFlairClass(post!.authorFlairText)
//        RKClient.sharedClient().userWithUsername(comment!.author) { (user, error) -> Void in
//            if let user = user as? RKUser {
//                print("got user now what?")
//            }
//        }
    }
    
    

    @IBAction func expandButtonTouchUpInside(sender: AnyObject) {
        if let treeView = treeView {
            if treeView.isCellExpanded(self) == true {
                let item = treeView.itemForCell(self)
                treeView.collapseRowForItem(item)
                self.expandButton.transform = CGAffineTransformIdentity
            } else {
                let item = treeView.itemForCell(self)
                treeView.expandRowForItem(item)
                self.expandButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            }
        }
    }

    
    
    //        let parser = ZHMarkdownParser(string: (comment?.body)!)
    //        let html = parser.HTML
    //        let data = html.dataUsingEncoding(NSUTF8StringEncoding)
    //        let options = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
    //        do {
    //            let attrString = try NSAttributedString(data: data!, options: options, documentAttributes: nil)
    //            commentTextView.attributedText = attrString
    //        } catch _ {
    //            print("uh oh!")
    //        }


    
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
    
}


extension ZHRedditCommentTableViewCell: UITextViewDelegate {
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
}
