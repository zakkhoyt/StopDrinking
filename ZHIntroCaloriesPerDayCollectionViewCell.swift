//
//  ZHIntroCaloriesPerDayCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroCaloriesPerDayCollectionViewCell: ZHIntroCollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textView: UITextView!
    
    
    override var user: ZHUserModel? {
        didSet {
            if user?.caloriesPerDrink == nil {
                stepper.value = 0
                nextButton.enabled = false
            } else {
                stepper.value = Double((user?.caloriesPerDrink)!)
                nextButton.enabled = true
            }
            updateLabel((user?.caloriesPerDrink)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if user?.caloriesPerDrink == nil {
            nextButton.enabled = false
            updateLabel(UInt(stepper.value))
        } else {
            updateLabel(UInt((user?.caloriesPerDrink!)!))
            stepper.value = Double((user?.caloriesPerDrink!)!)
            nextButton.enabled = true
        }
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        updateLabel(UInt(sender.value))
        nextButton.enabled = sender.value > 0 ? true : false
    }
    
    func updateLabel(value: UInt) {
        label.text = "\(value) Calories"
        user?.caloriesPerDrink = value
    }

}
