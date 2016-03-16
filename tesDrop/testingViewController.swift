//
//  testingViewController.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/13/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import BSImagePicker
import PhotosUI

class testingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillLayoutSubviews() {
        testingView()
    }
    
    

    
    func testingView(){
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
                
                self.dismissViewControllerAnimated(true, completion: nil)
                //NSNotificationCenter.defaultCenter().postNotificationName(goToHomeViewNotification, object: nil)
                
                
            }, finish: { (assets: [PHAsset]) -> Void in
                // User finished with these assets
                
                
                
            }, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
