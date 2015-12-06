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

    @IBOutlet weak var avatarView: ZHAvatarView!
    @IBOutlet weak var summaryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        user = ZHUserDefaults.sharedInstance.currentUser()
        self.preferredContentSize = CGSizeMake(0, 60);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = user {
            avatarView.user = user
            summaryLabel.text = user.stringForDaysQuit()
        } else {
            summaryLabel.text = "Open Stop Drinking to get started"
        }
        
        
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}
