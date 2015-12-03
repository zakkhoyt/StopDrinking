//
//  ZHIntroRedditCollectionViewCell.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHIntroRedditCollectionViewCell: ZHIntroCollectionViewCell {

    var viewController: UIViewController? = nil
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signedInLabel: UILabel!
    
    
    override var user: ZHUserModel? {
        didSet {
            if user?.redditUsername == nil {
                // Show sign in button
                // Show later button
                // Hide sign out button
                // Hide signed in label
                signInButton.hidden = false
                nextButton.setTitle("Later", forState: UIControlState.Normal)
                nextButton.hidden = false
                signOutButton.hidden = true
                signedInLabel.hidden = true
                
            } else {
                // Hide sign in button
                // Hide later button
                // Show sign out buton
                // Show signed in label
                
                signInButton.hidden = true
                nextButton.setTitle("Next", forState: UIControlState.Normal)
                nextButton.hidden = false
                signOutButton.hidden = false
                signedInLabel.hidden = false
                signedInLabel.text = "Signed in as " + (user?.redditUsername)!
            }
//            updateLabel((user?.caloriesPerDrink)!)
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.errorLabel.alpha = 0
    }
    
    
    @IBAction func signInButtonTouchUpInside(sender: AnyObject) {
        
        
        var usernameTextField: UITextField?
        var passwordTextField: UITextField?
        let ac = UIAlertController(title: "Enter Password", message: "You have selected to enter your passwod.", preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in

            MBProgressHUD.showHUDAddedTo(self, animated: true)
            
            let user = ac.textFields?[0].text
            let pass = ac.textFields?[1].text
            RKClient.sharedClient().signInWithUsername(user, password: pass) { (error) -> Void in
                if error != nil {
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
                    self.user?.redditUsername = user
                    self.user?.redditPassword = pass
                    self.user = self.user! // this triggers UI updates
                    if(self.nextHandler != nil){
                        self.nextHandler()
                    }
                }
                MBProgressHUD.hideHUDForView(self, animated: true)
            }
        }))
        ac.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Username"
            textField.secureTextEntry = false
            usernameTextField = textField
        })
        ac.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
            passwordTextField = textField
        })

        
        viewController!.presentViewController(ac, animated: true, completion: nil)
    }
    
    @IBAction func signOutButtonTouchUpInside(sender: AnyObject) {
        RKClient.sharedClient().signOut()
        user?.redditUsername = nil
        user?.redditPassword = nil
        user = user! // this triggers UI updates
    }
    
}
