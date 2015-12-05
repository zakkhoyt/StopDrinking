//
//  ZHRedditThreadTableViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/5/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHRedditThreadTableViewCell: UITableViewCell {

    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    
    var index: UInt = 0 {
        didSet {
            indexLabel.text = "\(index + 1)"
        }
    }
    var post: RKLink? = nil{
        didSet{
            postTextView.text = post!.title
            userLabel.text = "-" + post!.author
            
//            UIView.animateWithDuration(3.0, animations: { () -> Void in
                self.layoutIfNeeded()
//            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indexLabel.text = ""
    }

    
    class func cellFromNib() -> ZHRedditThreadTableViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("ZHRedditThreadTableViewCell", owner: self, options: nil).first
        return cell as! ZHRedditThreadTableViewCell
    }

}
