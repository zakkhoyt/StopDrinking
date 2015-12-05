//
//  ZHRedditCommentTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/24/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHRedditCommentTableViewCell: UITableViewCell {

    var expandButtonHandler:((expand: Bool)->Void)!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!


    @IBOutlet weak var arrowButton: UIButton!
    

    @IBOutlet weak var indentConstrint: NSLayoutConstraint!
    
    
    var expanded: Bool = false {
        didSet{
            renderCellContents()
        }
    }
    
    var level: Int = 0{
        didSet{
            indentConstrint.constant = 8 + CGFloat(level) * 16
        }
    }
    
    var comment: RKComment? = nil {
        didSet{

            renderCellContents()
        }
    }
    

    @IBAction func test(sender: AnyObject) {
        if expandButtonHandler != nil {
            expanded = !expanded
            
            if expanded == false {
                // point arrow to the right
                UIView .animateWithDuration(0.3, animations: { () -> Void in
                    self.arrowButton.transform = CGAffineTransformIdentity
                })

            } else {
                // point arrow down
                UIView .animateWithDuration(0.3, animations: { () -> Void in
                    self.arrowButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                })
            }
            
            
            expandButtonHandler(expand: expanded)
        }
    }
    
    func renderCellContents() {
        commentTextView.text = comment?.body
        
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

        if comment?.replies.count > 0 {
            arrowButton.hidden = false
        } else {
            arrowButton.hidden = true
        }
        
        
        userLabel.text = NSString(format: "%@", comment!.author) as String
        votesLabel.text = NSString(format: "+%lu", comment!.score) as String
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
