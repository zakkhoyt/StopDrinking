//
//  ZHIntroRedditCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroRedditCollectionViewCell: ZHIntroCollectionViewCell {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.errorLabel.alpha = 0
    }
    
    
    @IBAction func signInButtonTouchUpInside(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self, animated: true)
        RKClient.sharedClient().signInWithUsername(usernameTextField.text, password: passwordTextField.text) { (error) -> Void in
            if error != nil {
                print("Error: " + error.description)
                
                self.errorLabel.text = error.localizedDescription + "\nTry again"
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.errorLabel.alpha = 1.0
                    }, completion: { (animated) -> Void in
                        UIView.animateWithDuration(0.3, delay: 2, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                            self.errorLabel.alpha = 0
                            }, completion: { (animated) -> Void in
                                
                        })
                })
            } else {
                self.user?.redditUsername = self.usernameTextField.text
                self.user?.redditPassword = self.passwordTextField.text
                print("Success")
                if(self.nextHandler != nil){
                    self.nextHandler()
                }
            }
            MBProgressHUD.hideHUDForView(self, animated: true)
        }
    }

}
