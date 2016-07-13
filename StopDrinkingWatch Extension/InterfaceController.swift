//
//  InterfaceController.swift
//  StopDrinkingWatch Extension
//
//  Created by Zakk Hoyt on 1/21/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    var session: WCSession? = nil
    var user: ZHUserModel? = nil
    
    
    @IBOutlet var badgeImage: WKInterfaceGroup!
    @IBOutlet var badgeLabel: WKInterfaceLabel!
    
    @IBOutlet var summaryLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        user = ZHUserDefaults.sharedInstance.currentUser()
        startSession()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        refreshUI()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    @IBAction func buttonAction() {
        sendTap()
    }
    
    private func startSession() {
        if(WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session?.delegate = self
            session?.activateSession()
        }
    }
    
    private func sendTap() {
        if let session = session where session.reachable {
            session.sendMessage(["user": "a user dictionary"], replyHandler: { (replies: [String : AnyObject]) -> Void in
                if let reply = replies["reply"] as? String {
                    print("Received reply: " + reply)
                } else {
                    print("Failed to parse message")
                }
                }, errorHandler: { (error: NSError) -> Void in
                print("error: " + error.localizedDescription)
            })
        }
    }
    
    private func refreshUI() {
        if let user = user {
            
            if let days = user.daysSinceStartDate() {
                
                // badge Image
                badgeImage.setBackgroundImage(ZHAvatar.imageForDaysQuit(days))
                
                // badge text color
                badgeLabel.setTextColor(ZHAvatar.colorForDaysQuit(days))
                
                // badge text
                badgeLabel.setText(ZHAvatar.stringForDaysQuit(days))

            }
            
            
            let summary = user.shortStringForDaysQuit() + "\n" +
                user.shortStringForDrinksMissed() + "\n" +
                user.shortStringForMoneyMissed() + "\n" +
                user.shortStringForCaloriesMissed()
            
            summaryLabel.setText(summary)
        } else {
            summaryLabel.setText("Open Stop Drinking on your iPhone")
        }
    }
}

extension InterfaceController: WCSessionDelegate {
    
    
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        if let userDictionary = message["user"] as? Dictionary<String, AnyObject> {
            let user = ZHUserModel(dictionary: userDictionary)
            self.user = user
            ZHUserDefaults.sharedInstance.setCurrentUser(user)
            refreshUI()

        } else {
            print("Could not parse user message")
        }
    }
    

}