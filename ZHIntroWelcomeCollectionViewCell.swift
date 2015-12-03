//
//  ZHIntroWelcomeCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroWelcomeCollectionViewCell: ZHIntroCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellFromNib() -> ZHIntroWelcomeCollectionViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("ZHIntroWelcomeCollectionViewCell", owner: self, options: nil).first
        return cell as! ZHIntroWelcomeCollectionViewCell
    }

}
