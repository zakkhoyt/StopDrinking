//
//  ZHSummaryInterfaceController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 1/21/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import WatchKit
import Foundation


class ZHSummaryInterfaceController: WKInterfaceController {
    
    var user: ZHUserModel? = nil
    
    @IBOutlet var summaryLabel: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        summaryLabel.setText("Yo yo yo")
        
        user = ZHUserDefaults.sharedInstance.currentUser()
        if let user = user {
//            summaryView.user = user
//            completionHandler(NCUpdateResult.NewData)
            summaryLabel.setText(user.stringForDaysQuit())
        } else {
//            summaryView.user = nil
//            completionHandler(NCUpdateResult.NoData)
            summaryLabel.setText("No user yet")
        }

        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
