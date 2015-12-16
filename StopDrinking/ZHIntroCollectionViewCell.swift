//
//  ZHIntroCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroCollectionViewCell: UICollectionViewCell {
    var user: ZHUserModel? = nil
    var nextHandler:(()->Void)!
    var helpHandler:(()->Void)!
 
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    @IBAction func nextButtonTouchUpInside(sender: AnyObject) {
        if nextHandler != nil {
            nextHandler()
        }
    }

    @IBAction func helpButtonTouchUpInside(sender: AnyObject) {
        if helpHandler != nil {
            helpHandler()
        }
    }
}
