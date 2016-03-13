//
//  Contribute.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse
import BSImagePicker
import PhotosUI

class Contribute: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var moreImageView: UIImageView!
    
    //var addCount: Int!
    
    var editedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addCount = 0
        //        let imageView = profileImageView
        //        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        //        imageView.userInteractionEnabled = true
        //        imageView.addGestureRecognizer(tapGestureRecognizer)
        //
        // imageTapped()
        
         customImagePicker()

        
    }
    
    
    //    override func viewWillAppear(animated: Bool) {
    //        customImagePicker()
    //    }
    
    func customImagePicker(){
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    //        NSNotificationCenter.defaultCenter().postNotificationName(goToHomeViewNotification, object: nil)
    //    }
    
    
    
    //    //Step 1: Picking a Picture from the Camera Roll
    //    func imageTapped()
    //    {
    //        let vc = UIImagePickerController()
    //        vc.delegate = self
    //        vc.allowsEditing = true
    //        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    //        self.presentViewController(vc, animated: true, completion: nil)
    //    }
    
    
    //    //Step 1: Picking a Picture from the Camera Roll
    //    func imageTapped(img: AnyObject)
    //    {
    //        let vc = UIImagePickerController()
    //        vc.delegate = self
    //        vc.allowsEditing = true
    //        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    //        self.presentViewController(vc, animated: true, completion: nil)
    //    }
    
    //    //Step 2: Implement the delegate
    //    func imagePickerController(picker: UIImagePickerController,
    //        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    //            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    //            editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    //            profileImageView.image = editedImage
    //            dismissViewControllerAnimated(true, completion: { () -> Void in
    //                //self.performSegueWithIdentifier("selectToUpload", sender: nil)
    //            })
    //    }
    
    //    func resize(image: UIImage, newSize: CGSize) -> UIImage {
    //        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
    //        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
    //        resizeImageView.image = image
    //
    //        UIGraphicsBeginImageContext(resizeImageView.frame.size)
    //        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        return newImage
    //    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //self.performSegueWithIdentifier("selectToUpload", sender: nil)
        let passThisImage = editedImage
        let detailViewController = segue.destinationViewController as! Filter
        detailViewController.readyImage = passThisImage!
        
    }
    
    //    @IBAction func addBtn(sender: UIBarButtonItem) {
    //        let vc = UIImagePickerController()
    //        vc.delegate = self
    //        vc.allowsEditing = true
    //        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    //        self.presentViewController(vc, animated: true, completion: nil)
    //    }

}
