//
//  Login.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse

class Login: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //background gradient color variables
    var gradient : CAGradientLayer?
    var toColors : AnyObject?
    var fromColors : AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 4
        bgGradientsColor()
        
        
        //        if (usernameField.text!.isEmpty) {
        //            let alert = UIAlertView()
        //            alert.title = "No Text"
        //            alert.message = "Please Enter Text In The Box"
        //            alert.addButtonWithTitle("Ok")
        //            alert.show()
        //        }
        loginButton.enabled = false
        loginButton.alpha = 0.5
        usernameField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    //disable Login Button when username/password fields are empty. Enabled when both are filled
    func textFieldDidChange(textField: UITextField) {
        if (usernameField.text!.isEmpty || passwordField.text!.isEmpty) {
            loginButton.enabled = false
            loginButton.alpha = 0.5
        } else {
            loginButton.enabled = true
            loginButton.alpha = 1.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    
    
    // user log in method
    @IBAction func onLogin(sender: AnyObject) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
        }
    }
    
    
    //    // switch to sign up view
    //    @IBAction func onSingup(sender: AnyObject) {
    //        // manually segue to logged in view
    //        self.performSegueWithIdentifier("signupSegue", sender: nil)
    //    }
    //
    // dismiss keyboard
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    func bgGradientsColor() {
        
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [UIColor.cyanColor().CGColor, UIColor.lightGrayColor().CGColor]
        self.view.layer.insertSublayer(self.gradient!, atIndex: 0)
        
        self.toColors = [UIColor.magentaColor().CGColor, UIColor.orangeColor().CGColor]
        //self.toColors = [UIColor.orangeColor().CGColor, UIColor.cyanColor().CGColor]
        //self.toColors = [UIColor.purpleColor().CGColor, UIColor.magentaColor().CGColor]
        
        //cyanColor(), magentaColor(), redColor(), greenColor(), purpleColor(), orangeColor()
        
        animateLayer()
        gradient!.startPoint = CGPointZero;
        gradient!.endPoint = CGPointMake(1, 1);
    }
    
    func animateLayer(){
        
        self.fromColors = self.gradient?.colors
        self.gradient!.colors = self.toColors! as? [AnyObject]
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.delegate = self
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 7.00
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.addAnimation(animation, forKey:"animateGradient")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        self.toColors = self.fromColors;
        self.fromColors = self.gradient?.colors
        
        animateLayer()
    }

}
