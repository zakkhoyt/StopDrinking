//
//  ZHIntroStartDateCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit


class ZHIntroStartDateCollectionViewCell: ZHIntroCollectionViewCell {

    
    
    @IBOutlet weak var datePickerView: RSDFDatePickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePickerView.dataSource = self
        datePickerView.delegate = self

        if user?.startDate == nil {
            nextButton.enabled = false
        } else {
            datePickerView.selectDate(user?.startDate)
            nextButton.enabled = true
        }
        
    }

    class func cellFromNib() -> ZHIntroStartDateCollectionViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("ZHIntroStartDateCollectionViewCell", owner: self, options: nil).first
        return cell as! ZHIntroStartDateCollectionViewCell
    }

}


extension ZHIntroStartDateCollectionViewCell: RSDFDatePickerViewDataSource{
    func datePickerView(view: RSDFDatePickerView!, shouldMarkDate date: NSDate!) -> Bool {
        let startDate = user?.startDate
        if startDate == nil{
            return false
        }
        
        if date.timeIntervalSince1970 >= user?.startDate!.timeIntervalSince1970 &&
            date.timeIntervalSince1970 < NSDate().timeIntervalSince1970 {
                return true
        } else {
            return false
        }
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
    
    func datePickerView(view: RSDFDatePickerView!, shouldSelectDate date: NSDate!) -> Bool {
        return true;
    }
    

}
