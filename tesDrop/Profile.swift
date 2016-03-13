//
//  Profile.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse

let userDidLogoutNotification = "userDidLogoutNotification"

class Profile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var prifileImageBtn: UIButton!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil {                                   //viewing own profile
            user = PFUser.currentUser()
        }
        
        if prifileImageBtn.backgroundImageForState(.Normal) == nil {
            prifileImageBtn.setBackgroundImage(UIImage(named:"uploadGrey"), forState: .Normal)
        }
        
        prifileImageBtn.clipsToBounds = true
        prifileImageBtn.layer.masksToBounds = true
        prifileImageBtn.layer.cornerRadius = prifileImageBtn.frame.width/2
        
        handleLabel.text = user?.username
        handleLabel.font = UIFont(name: "Chalkduster", size: 24)
        
        let imageFile = user!["profile"] as? PFFile
        imageFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
            let image = UIImage(data: data!)
            self.prifileImageBtn.setBackgroundImage(image, forState: .Normal)
            self.prifileImageBtn.setTitle("", forState: .Normal)
        })
        
        
        if user != PFUser.currentUser() {          //viewing other users profile
            prifileImageBtn.userInteractionEnabled = false
            logoutBtn.hidden = true
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        print("User logged out successfully")
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
    }
    
    @IBAction func onProfileBtnClicked(sender: AnyObject) {
        
        let actionSheet = UIAlertController(title: "Pick a source", message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Take a picture", style: .Default) { (action) -> Void in
            //take a picture
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
        let photoAction = UIAlertAction(title: "From Camera roll", style: .Default) { (action) -> Void in
            //pick from camera roll
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cancel)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        prifileImageBtn.setTitle("", forState: .Normal)
        prifileImageBtn.setBackgroundImage(image, forState: .Normal)
        
        if let imageData = UIImagePNGRepresentation(image) {
            PFUser.currentUser()!["profile"] = PFFile(name: "image.png", data: imageData)
            PFUser.currentUser()!.saveInBackground()
        }
        
        
    }
    override func viewDidDisappear(animated: Bool) {
        navigationController?.popViewControllerAnimated(false)
    }

}
