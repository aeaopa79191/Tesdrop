//
//  userData.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse
import PhotosUI


class userData: NSObject {
    
    class func postUserImage(images: [UIImage], withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        let imgCount = (images.count) as Int
        print("img Count is \(imgCount)")
        
//        for index in 0...imgCount{
//            print("Current image on upload  is \(images)")
//            let image = images[index] as? UIImage
//            media["media"] = getPFFileFromImage(image) // PFFile column type
//
//        }
        
        if (imgCount >= 0 ){
            for index in 0..<imgCount {
                print(index)
                print("Current image on upload  is \(images)")
                let image = images[index] as? UIImage
                media["media\(index)"] = getPFFileFromImage(image) // PFFile column type
            }
        }
        
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["likesCount"] = 0
        media["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to post user media to Parse by uploading image file
     
     - parameter image: Image that the user wants upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
}
