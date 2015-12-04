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
    @IBOutlet weak var userLabel: UILabel!
    
    var index: UInt = 0
    var post: RKLink? = nil{
        didSet{
            postTextView.text = post!.title
            userLabel.text = "-" + post!.author
            
            UIView.animateWithDuration(3.0, animations: { () -> Void in
                self.layoutIfNeeded()
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


