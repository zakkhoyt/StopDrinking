//
//  ZHDailyTip.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 1/31/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHDailyTip: NSObject {
    
    static let tips = [
        "You will immediately start having more money.",
        "Your brain will begin to heal.",
        "Your liver will begin to rejuvenate.",
        "You will no longer need to hide the evidence of drinking from your family.",
        "Your spouse or significant other will have a new-found respect for you.",
        "Your face will begin to clear up and your complexion will show dramatic improvement.",
        "All the little aches and pains throughout your body will slowly but surely go away.",
        "You will never again have to face a hangover.",
        "You will start feeling remarkably better within just a couple of days.",
        "You will stop hating yourself for wasting money.",
        "Your natural energy will slowly but surely return.",
        "You will no longer worry about having a supply of booze.",
        "Your sex life will improve immensely.",
        "You will be more refreshed in the morning.",
        "You won’t miss work due to drinking.",
        "Your friends will admire you for having the strength to quit.",
        "You will stop wasting time sitting at a bar.",
        "Your five senses will return better than ever.",
        "People will tell you how much better you look.",
        "You will no longer feel trapped by an addiction.",
        "Nothing will come between you and your goals.",
        "You will find joy in all the little things of life.",
        "Your family will love the new you.",
        "You will feel better than you have in years.",
        "Your youthful exuberance for life will return.",
        "You will feel in control of your decisions.",
        "You will constantly smile and laugh.",
        "You will realize how many blessings you have.",
        "You will be truly optimistic about your future.",
        "You will feel happier than ever.",
    ]
    
    class func randomTip() -> String {
        let index = arc4random_uniform(UInt32(ZHDailyTip.tips.count))
        let tip = ZHDailyTip.tips[Int(index)]
        return tip
    }
    
    class func tip(dayOfMonth: UInt) -> String {
        let tip = ZHDailyTip.tips[Int(dayOfMonth)]
        return tip
    }
    
    
    
}
