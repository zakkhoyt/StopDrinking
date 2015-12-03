//opDr
//  ZHIntroDrinksPerDayCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroDrinksPerDayCollectionViewCell: ZHIntroCollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if user?.drinksPerDay == nil {
            nextButton.enabled = false
            updateLabel(UInt(stepper.value))
        } else {
            updateLabel(UInt((user?.drinksPerDay!)!))
            stepper.value = Double((user?.drinksPerDay!)!)
            nextButton.enabled = true
        }
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        updateLabel(UInt(sender.value))

        nextButton.enabled = sender.value > 0 ? true : false
    }
    
    func updateLabel(value: UInt) {
        label.text = "\(value)"
        user?.drinksPerDay = value
    }

}
