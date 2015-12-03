//
//  ZHIntroCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroCollectionViewCell: UICollectionViewCell {
    var nextHandler:(()->Void)!
 
    
    @IBAction func nextButtonTouchUpInside(sender: AnyObject) {
        if nextHandler != nil {
            nextHandler()
        }
    }

}
