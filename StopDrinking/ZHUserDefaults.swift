//
//  ZHUserDefaults.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHUserDefaults: NSObject {

    class func setCurrentUser(user: ZHUserModel) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "currentUser")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func currentUser() -> ZHUserModel? {
        let data = NSUserDefaults.standardUserDefaults().objectForKey("currentUser") as? NSData
        if data == nil {
            return nil
        }
        let user = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? ZHUserModel
        return user
    }
    
}
