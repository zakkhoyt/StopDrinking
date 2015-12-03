//
//  ZHIntroStartDateCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit


class ZHIntroStartDateCollectionViewCell: ZHIntroCollectionViewCell {

    override var user: ZHUserModel? {
        didSet {
            if user?.startDate == nil {
                datePickerView.selectDate(NSDate())
                datePickerView.scrollToToday(true)
                nextButton.enabled = false
            } else {
                datePickerView.selectDate(user?.startDate)
//                datePickerView.scrollToDate(user?.startDate, animated: true)
                datePickerView.scrollToToday(true)
                nextButton.enabled = true
            }
        }
    }
    
    
    @IBOutlet weak var datePickerView: RSDFDatePickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePickerView.dataSource = self
        datePickerView.delegate = self

        
    }

    class func cellFromNib() -> ZHIntroStartDateCollectionViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("ZHIntroStartDateCollectionViewCell", owner: self, options: nil).first
        return cell as! ZHIntroStartDateCollectionViewCell
    }

}


extension ZHIntroStartDateCollectionViewCell: RSDFDatePickerViewDataSource{
    func datePickerView(view: RSDFDatePickerView!, shouldMarkDate date: NSDate!) -> Bool {
        if let startDate = user?.startDate {

            // Only mark the progress days (zone)
            if date.timeIntervalSince1970 >= startDate.timeIntervalSince1970 &&
                date.timeIntervalSince1970 <= NSDate().timeIntervalSince1970 {
                    return true
            } else {
                return false
            }
        }
        return false
    }
    
    func datePickerView(view: RSDFDatePickerView!, isCompletedAllTasksOnDate date: NSDate!) -> Bool {
        return false
    }
    
    func datePickerView(view: RSDFDatePickerView!, markImageColorForDate date: NSDate!) -> UIColor! {
        return UIColor.greenColor()
    }
    
    func datePickerView(view: RSDFDatePickerView!, markImageForDate date: NSDate!) -> UIImage! {
        return UIImage(named: "stop")
    }
    

}


extension ZHIntroStartDateCollectionViewCell: RSDFDatePickerViewDelegate{

    func datePickerView(view: RSDFDatePickerView!, didSelectDate date: NSDate!) {
        print("selected date: " + date.description)
        user?.startDate = date
        nextButton.enabled = true
    }

    func datePickerView(view: RSDFDatePickerView!, shouldHighlightDate date: NSDate!) -> Bool {
        if date.timeIntervalSince1970 <= NSDate().timeIntervalSince1970 {
            return true
        } else {
            // TODO: Popup label
            return false
        }
    }
    
    func datePickerView(view: RSDFDatePickerView!, shouldSelectDate date: NSDate!) -> Bool {
        if date.timeIntervalSince1970 <= NSDate().timeIntervalSince1970 {
            return true
        } else {
            // TODO: Popup label
            return false
        }

    }
    

}
