//
//  ZHHomeSummaryTableViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHHomeSummaryTableViewCell: UITableViewCell {

    

    @IBOutlet var avatarView: ZHAvatarView!

    
    @IBOutlet weak var daysQuitLabel: UILabel!
    @IBOutlet weak var drinksMissedLabel: UILabel!
    @IBOutlet weak var moneyMissedLabel: UILabel!
    @IBOutlet weak var caloriesMissedLabel: UILabel!

    var user: ZHUserModel? = nil {
        didSet {
            avatarView.user = user
            let daysQuit = user?.stringForDaysQuit()
            daysQuitLabel.text = daysQuit
            drinksMissedLabel.text = user?.stringForDrinksMissed()
            moneyMissedLabel.text = user?.stringForMoneyMissed()
            caloriesMissedLabel.text = user?.stringForCaloriesMissed()
        }
    }
}
