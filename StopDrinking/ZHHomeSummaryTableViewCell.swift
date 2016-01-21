//
//  ZHHomeSummaryTableViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHHomeSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var summaryView: ZHSummaryView!
    
    
    var user: ZHUserModel? = nil {
        didSet {
            if let user = user {
                summaryView.user = user
            }
        }
    }
}
