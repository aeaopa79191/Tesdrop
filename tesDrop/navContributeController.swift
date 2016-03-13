//
//  navContributeController.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/13/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import BSImagePicker
import PhotosUI

let goToHomeViewNotification = "goToHomeViewNotification"

class navContributeController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameriaView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    let vc = self.storyboard!.instantiateViewControllerWithIdentifier("captureViewID") as UIViewController
//    self.presentViewController(vc, animated: true, completion: nil)
    
    func cameriaView(){
        let vc = BSImagePickerViewController()
        
        bs_presentImagePickerController(vc, animated: true,
            select: { (asset: PHAsset) -> Void in
                // User selected an asset.
                // Do something with it, start upload perhaps?
                
                
            }, deselect: { (asset: PHAsset) -> Void in
                // User deselected an assets.
                // Do something, cancel upload?
            }, cancel: { (assets: [PHAsset]) -> Void in
                // User cancelled. And this where the assets currently selected.
                
                //self.dismissViewControllerAnimated(true, completion: nil)
                //NSNotificationCenter.defaultCenter().postNotificationName(goToHomeViewNotification, object: nil)
                
                
            }, finish: { (assets: [PHAsset]) -> Void in
                // User finished with these assets
                
                
                
            }, completion: nil)
        
    }
//    
//    override func viewWillAppear(animated: Bool) {
//        cameriaView()
//        
//    }
    

}
