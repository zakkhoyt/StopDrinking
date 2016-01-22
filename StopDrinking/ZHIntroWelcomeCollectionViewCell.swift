//
//  ZHIntroWelcomeCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroWelcomeCollectionViewCell: ZHIntroCollectionViewCell {

    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.text = "Welcome to Stop Drinking, an app which uses the /r/sd community and your own progress to keep you motivated and off of alcohol. To get started just tap the next button and answer a few questions."
    }
    
    class func cellFromNib() -> ZHIntroWelcomeCollectionViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("ZHIntroWelcomeCollectionViewCell", owner: self, options: nil).first
        return cell as! ZHIntroWelcomeCollectionViewCell
    }

}
