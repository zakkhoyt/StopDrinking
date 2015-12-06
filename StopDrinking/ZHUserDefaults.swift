//
//  ZHUserDefaults.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHUserDefaults: NSObject {

    static let sharedInstance = ZHUserDefaults()
    
    var groupDefaults = NSUserDefaults(suiteName: "group.com.vaporwarewolf.StopDrinking")
    
    func setCurrentUser(user: ZHUserModel) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        groupDefaults?.setObject(data, forKey: "currentUser")
        groupDefaults?.synchronize()
    }
    
    func currentUser() -> ZHUserModel? {
        let data = groupDefaults?.objectForKey("currentUser") as? NSData
        if data == nil {
            return nil
        }
        let user = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? ZHUserModel
        return user
    }
    
}
