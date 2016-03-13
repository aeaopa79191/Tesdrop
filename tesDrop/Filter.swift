//
//  Filter.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

let goToHomeViewNotification = "goToHomeViewNotification"

class Filter: UIViewController {

    var window: UIWindow?
    
    @IBOutlet weak var captionField: UITextField!
    
    @IBOutlet weak var uplodaImage: UIImageView!
    var readyImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uplodaImage.image = readyImage
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onUpload(sender: AnyObject) {
        userData.postUserImage(uplodaImage.image, withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Upload succesfully")
                self.uplodaImage.image = nil
                self.captionField.text = ""
                
                NSNotificationCenter.defaultCenter().postNotificationName(goToHomeViewNotification, object: nil)
                
                
                //                let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("HomeViewID")
                //                self.navigationController!.pushViewController(VC1, animated: true)
                
            }
            else {
                print("Can't post to parse")
            }
        }
        
    }

}
