//
//  ZHIntroStartDateCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroStartDateCollectionViewCell: ZHIntroCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func cellFromNib() -> ZHIntroStartDateCollectionViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("ZHIntroStartDateCollectionViewCell", owner: self, options: nil).first
        return cell as! ZHIntroStartDateCollectionViewCell
    }

}
