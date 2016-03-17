//
//  userData.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse

class userData: NSObject {
//    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
//        // Create Parse object PFObject
//        let media = PFObject(className: "userData")
//        
//        // Add relevant fields to the object
//        media["media"] = getPFFileFromImage(image) // PFFile column type
//        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
//        media["caption"] = caption
//        media["likesCount"] = 0
//        media["commentsCount"] = 0
//        
//        // Save object (following function will save the object in Parse asynchronously)
//        media.saveInBackgroundWithBlock(completion)
//    }

    class func postUserImage(pdfFile: NSData?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "userData")
        
        // Add relevant fields to the object
        media["media"] = getPFFileFromPDF(pdfFile) // PFFile column type
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
    
    class func getPFFileFromPDF(pdfFile: NSData?) -> PFFile? {
        if let pdfFile = pdfFile {
            //if let pdfData = UIImagePNGRepresentation(pdfFile) {
                return PFFile(name: "pdf.pdf", data: pdfFile)
            //}
        }
        return nil
    }
}
