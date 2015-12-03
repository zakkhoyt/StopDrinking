//
//  ZHIntroMoneyPerDayCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroMoneyPerDayCollectionViewCell: ZHIntroCollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    override var user: ZHUserModel? {
        didSet {
            if user?.moneyPerDay == nil {
                stepper.value = 0
                nextButton.enabled = false
            } else {
                stepper.value = Double((user?.moneyPerDay)!)
                nextButton.enabled = true
            }
            updateLabel((user?.moneyPerDay)!)
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        if user?.moneyPerDay == nil {
            nextButton.enabled = false
            updateLabel(UInt(stepper.value))
        } else {
            updateLabel(UInt((user?.moneyPerDay!)!))
            stepper.value = Double((user?.moneyPerDay!)!)
            nextButton.enabled = true
        }
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        updateLabel(UInt(sender.value))
        nextButton.enabled = sender.value > 0 ? true : false
    }
    
    func updateLabel(value: UInt) {
        label.text = "$\(value)"
        user?.moneyPerDay = value
    }
}
