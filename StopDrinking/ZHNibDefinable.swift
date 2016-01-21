//
//  ZHNibDefinable.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 1/21/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

protocol ZHNibDefinable {
    var nibName: String { get }
    func xibSetup()
    func loadViewFromXib() -> UIView
}


extension ZHNibDefinable {
    var nibName : String {
        return String(self.dynamicType)
    }
}



//class ZHAvatarView: UIView, ZHNibDefinable {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        xibSetup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        xibSetup()
//    }
//    
//    func xibSetup() {
//        view = loadViewFromXib()
//        view.frame = bounds
//        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//        backgroundColor = .clearColor()
//        addSubview(view)
//    }
//    
//    private func loadViewFromXib() -> UIView {
//        let bundle = NSBundle(forClass: self.dynamicType)
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
//        return view
//    }
//}