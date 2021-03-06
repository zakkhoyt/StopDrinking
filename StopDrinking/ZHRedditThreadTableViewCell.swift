//
//  ZHRedditThreadTableViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/5/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//
// ** RKVotable
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
//  index
//  .title  
//  .author
//  .created
//  .score
//  .gilded
//  .totalComments
//  .totalReports
//  .authorFlairText: "month3"
//  .authorFlairClass: "112 days"


import UIKit

class ZHRedditThreadTableViewCell: UITableViewCell {

    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var pointCountLabel: UILabel!
    @IBOutlet weak var avatarView: ZHAvatarView!
    @IBOutlet weak var borderView: UIView!
    var showDetails = false
    
    var index: UInt = 0 {
        didSet {
            indexLabel.text = "\(index + 1)"
            borderView.hidden = false
        }
    }
    var post: RKLink? = nil{
        didSet{
            // Create attributed string for the title. Possibly appending selfText
            let title = post!.title
            let titleAttr = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
            ]
            let attrTitle = NSAttributedString(string: title, attributes: titleAttr)

            if showDetails == true {
                let decodedSelfText = ZHStringFormatter.bodyHTMLToAttributedString(post!.selfTextHTML)
                let attrText = NSMutableAttributedString()
                attrText.appendAttributedString(attrTitle)
                attrText.appendAttributedString(NSAttributedString(string: "\n\n"))
                attrText.appendAttributedString(decodedSelfText)
                postTextView.attributedText = attrText
            } else {
                postTextView.attributedText = attrTitle
            }

            ageLabel.text = post!.created.stringRelativeTimeFromDate()
            commentCountLabel.text = "\(post!.totalComments) comments"
            pointCountLabel.text = "\(post!.score) points"
            
            if let authorFlairText = post!.authorFlairText {
                hidden = false
                let sub = authorFlairText.componentsSeparatedByString(" ")
                if sub.count > 0 {
                    let days = UInt(sub.first!)
                    if let days = days {
                        userLabel.text = "-" + post!.author + "\n\(days) days"
                    }
                }

            } else {
                userLabel.text = "-" + post!.author
            }

            avatarView.configureForFlairClass(post!.authorFlairText)
        }
    }
    
//    func getFlair() {
//        RKClient.sharedClient().
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indexLabel.text = ""
        borderView.hidden = true
    }

    
    class func cellFromNib() -> ZHRedditThreadTableViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("ZHRedditThreadTableViewCell", owner: self, options: nil).first as? ZHRedditThreadTableViewCell
        return cell!
    }

}
