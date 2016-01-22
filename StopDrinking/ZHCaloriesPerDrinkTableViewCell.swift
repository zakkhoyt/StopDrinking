//
//  ZHCaloriesPerDrinkTableViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 1/21/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHCaloriesPerDrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var beverageLabel: UILabel!
    func setBeverage(beverage: String, calories: UInt) {
        beverageLabel.text = beverage
        caloriesLabel.text = "\(calories)"
    }

}
