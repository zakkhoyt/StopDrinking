//
//  ZHHomeSummaryTableViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHHomeSummaryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarContainerView: ZHAvatarView!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView = NSBundle.mainBundle().loadNibNamed("ZHAvatarView", owner: self, options: nil).first as? ZHAvatarView
        avatarView.frame = avatarContainerView.bounds
        avatarContainerView.addSubview(avatarView!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
