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
        let dictionary = user.dictionaryRepresentation()
        groupDefaults?.setObject(dictionary, forKey: "currentUser")
        groupDefaults?.synchronize()

    }
    
    func currentUser() -> ZHUserModel? {
        let dictionary = groupDefaults?.objectForKey("currentUser") as? Dictionary<String, AnyObject>
        if let dictionary = dictionary {
            let user = ZHUserModel(dictionary: dictionary)
            return user
        } else {
            return nil
        }

    }
    
}
