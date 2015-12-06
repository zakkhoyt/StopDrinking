//
//  ZHIntroNotificationsCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/5/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroNotificationsCollectionViewCell: ZHIntroCollectionViewCell {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeSwitch: UISwitch!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    override var user: ZHUserModel? {
        didSet {
            if user?.notificationTime == nil {
                // show image
                // hide picker
                // switch = off
                timePicker.hidden = true
                blurView.hidden = true
                timeSwitch.on = false
            } else {
                // hide image
                // show picker
                // set picker.date
                // switch = on
                timePicker.hidden = false
                blurView.hidden = false
                timePicker.date = (user?.notificationTime!)!
                timeSwitch.on = true
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        imageView.image = UIImage(named: "badge")
    }
    
    
    @IBAction func timeSwitchValueChanged(sender: UISwitch!) {
        if sender.on == false {
            timePicker.hidden = true
            blurView.hidden = true
            timeSwitch.on = false
            user?.notificationTime = nil
        } else {
            timePicker.hidden = false
            blurView.hidden = false
            timePicker.date = NSDate()
            user?.notificationTime = NSDate()
        }
    }
    
    
    @IBAction func timePickerValueChanged(sender: UIDatePicker!) {
        print("time: " + sender.date.description)
        user?.notificationTime = sender.date
    }
    
    
}
