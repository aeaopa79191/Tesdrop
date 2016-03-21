//
//  Email.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class Email: UIViewController {

    @IBOutlet weak var backToLogin: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backToLogin.layer.cornerRadius = 5
        nextButton.layer.cornerRadius = 5
        
        nextButton.enabled = false
        nextButton.alpha = 0.5
        emailTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //disable Login Button when username/password fields are empty. Enabled when both are filled
    func textFieldDidChange(textField: UITextField) {
        if (emailTextField.text!.isEmpty) {
            nextButton.enabled = false
            nextButton.alpha = 0.5
        } else {
            nextButton.enabled = true
            nextButton.alpha = 1.0
        }
    }
    
    //email validation check
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    @IBAction func backToLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    //show sign up sub view
    @IBAction func onNext(sender: AnyObject) {
        //        //newUser.email = emailLabel.text
        
        if isValidEmail(emailTextField.text!) == true {
            self.performSegueWithIdentifier("emailToSignup", sender: nil)
        }
        else {
            let alert = UIAlertController(title: "Email Error", message: "Please Enter an Appropriate Email Address", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)

        }
        
        
        //        //**************** Testing *******************
        //        let mailComposeViewController = configuredMailComposeViewController()
        //        if MFMailComposeViewController.canSendMail() {
        //            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        //        } else {
        //            self.showSendMailErrorAlert()
        //        }
        //
        //
        //    }
        //
        //
        //    func configuredMailComposeViewController() -> MFMailComposeViewController {
        //        let mailComposerVC = MFMailComposeViewController()
        //        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        //
        //        mailComposerVC.setToRecipients(["azpm95@gmail.com"])
        //        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        //        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        //
        //        return mailComposerVC
        //    }
        //
        //    func showSendMailErrorAlert() {
        //        let sendMailErrorAlert = UIAlertView(
        //            title: "Could Not Send Email",
        //            message: "Your device could not send e-mail.  Please check e-mail configuration and try again.",
        //            delegate: self,
        //            cancelButtonTitle: "OK")
        //
        //        sendMailErrorAlert.show()
        //    }
        //
        //    // MARK: MFMailComposeViewControllerDelegate
        //    
        //    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        //        controller.dismissViewControllerAnimated(true, completion: nil)
        //        
    }


}
