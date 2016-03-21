//
//  SignUp.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse

class SignUp: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        createButton.layer.cornerRadius = 5
        createButton.enabled = false
        createButton.alpha = 0.5
        
        usernameField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        rePasswordField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
    }
    
    //disable Login Button when username/password fields are empty. Enabled when both are filled
    func textFieldDidChange(textField: UITextField) {
        if (usernameField.text!.isEmpty || passwordField.text!.isEmpty || rePasswordField.text!.isEmpty) {
            createButton.enabled = false
            createButton.alpha = 0.5
        } else {
            createButton.enabled = true
            createButton.alpha = 1.0
        }
    }
    
    @IBAction func backToLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        //Password match check
        if(passwordField.text == rePasswordField.text){
            //username & password cannot match check
            if(usernameField.text != passwordField.text){
                //password's length > 8 char check
                if(passwordField.text?.characters.count > 8){
                    // call sign up function on the object
                    newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("User Registered successfully")
                            // manually segue to logged in view
                            self.performSegueWithIdentifier("signUpSegue", sender: nil)
                            //self.tabBarController?.selectedIndex = 0
                            
                        }//end else
                    }//end signUpInBackgroundWithBlock
                }else{
                    let alert = UIAlertController(title: "Warning", message: "Password needs to be at least 8 characters long for security reason.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(alertAction)in
                        alert.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            } else {
                let alert = UIAlertController(title: "Password Error", message: "Username cannot be the password", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(alertAction)in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } //end if
        else {
            let alert = UIAlertController(title: "Password Did Not Match", message: "Re-Enter your password", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
  
    } //end signUp


}
