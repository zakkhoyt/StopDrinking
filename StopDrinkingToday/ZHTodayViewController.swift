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
    @IBOutlet weak var summaryView: ZHSummaryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ZHTodayViewController.tapHandler(_:)))
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
            summaryView.user = user
            completionHandler(NCUpdateResult.NewData)
        } else {
            summaryView.user = nil
            completionHandler(NCUpdateResult.NoData)
        }
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}
