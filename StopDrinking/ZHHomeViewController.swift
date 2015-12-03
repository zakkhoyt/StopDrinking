//
//  ZHHomeViewController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHHomeViewController: UIViewController {
    let SegueMainToIntro = "SegueMainToIntro"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueMainToIntro {
            let vc = segue.destinationViewController as? ZHIntroViewController
            vc?.introCompleteHandler = ({ () -> Void in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            })
        }
    }


    @IBAction func introButtonTouchUpInside(sender: AnyObject) {
        performSegueWithIdentifier(self.SegueMainToIntro, sender: nil)
    }
}
