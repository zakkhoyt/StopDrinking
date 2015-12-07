//
//  ZHTodayViewController.swift
//  StopDrinkingToday
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import NotificationCenter

class ZHTodayViewController: UIViewController, NCWidgetProviding {
    
    var user: ZHUserModel? = nil


    @IBOutlet weak var avatarContainerView: UIView!
    @IBOutlet weak var daysQuitLabel: UILabel!
    @IBOutlet weak var drinksSavedLabel: UILabel!
    @IBOutlet weak var moneySavedLabel: UILabel!
    @IBOutlet weak var caloriesSavedLabel: UILabel!
    var avatarView: ZHAvatarView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        daysQuitLabel.text = ""
        drinksSavedLabel.text = ""
        moneySavedLabel.text = ""
        caloriesSavedLabel.text = ""

        
        let tap = UITapGestureRecognizer(target: self, action: "tapHandler:")
        self.view.addGestureRecognizer(tap)
    }

    func tapHandler(sender: UITapGestureRecognizer) {
        let myAppUrl = NSURL(string: "StopDrinking://today")!
        extensionContext?.openURL(myAppUrl, completionHandler: { (success) in
            if success == false {
                print("Could not launch main app for some reason")
            }
        })
    }
    
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        user = ZHUserDefaults.sharedInstance.currentUser()
        if let user = user {
            avatarView = NSBundle.mainBundle().loadNibNamed("ZHAvatarView", owner: self, options: nil).first as? ZHAvatarView
            avatarView!.frame = avatarContainerView.bounds
            avatarView!.user = user
            avatarContainerView.addSubview(avatarView!)
            daysQuitLabel.text = user.stringForDaysQuit()
            drinksSavedLabel.text = user.stringForDrinksMissed()
            moneySavedLabel.text = user.stringForMoneyMissed()
            caloriesSavedLabel.text = user.stringForCaloriesMissed()
            completionHandler(NCUpdateResult.NewData)
        } else {
            daysQuitLabel.text = "Open Stop Drinking to get started"
            drinksSavedLabel.text = ""
            moneySavedLabel.text = ""
            caloriesSavedLabel.text = ""
            completionHandler(NCUpdateResult.NoData)
        }
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}
