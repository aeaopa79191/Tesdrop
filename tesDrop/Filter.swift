//
//  Filter.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Photos
import Parse

class Filter: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var window: UIWindow?
    
    @IBOutlet weak var collectionView: UICollectionView!

    var readyImageCollection: PHAssetCollection = PHAssetCollection()
    var photosAsset: PHFetchResult!
    var assetThumbnailSize:CGSize!
    
    var pdfFile: NSData!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let cellSize = layout.itemSize
            self.assetThumbnailSize = CGSizeMake(cellSize.width, cellSize.height)
        }

        self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.readyImageCollection, options: nil)
        self.collectionView.reloadData()
   
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell: PhotoThumbnail = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbnail
        
        //Modify the cell
        let asset: PHAsset = self.photosAsset[indexPath.item] as! PHAsset
//        let photoCount = photosAsset.count
//        print(photoCount)
//        for index in 1...photoCount{
//            photoArray[index] = asset
//        }
//        
        // Create options for retrieving image (Degrades quality if using .Fast)
        //        let imageOptions = PHImageRequestOptions()
        //        imageOptions.resizeMode = PHImageRequestOptionsResizeMode.Fast
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: self.assetThumbnailSize, contentMode: .AspectFill, options: nil, resultHandler: {(result, info)in
            if let image = result {

               // cell.setThumbnailImage(image)
                print("what is this ?\(image)")
                cell.imgView.image = result!
                let omgvIEW = cell.imgView.image
                print(image)
                self.pdfFile = NSData.convertImageToPDF(omgvIEW!)
                print("converted pdf")
                
                
//                userData.postUserImage(omgvIEW, withCaption: "tseting") { (success: Bool, error: NSError?) -> Void in
//                    if success {
//                        print("Upload succesfully")
//                        
//                        //erase imageview after succes upload
//                        //self.imagePhoto!.image = nil
//                        //self.captionField.text = ""
//                        
//                        NSNotificationCenter.defaultCenter().postNotificationName(goToHomeViewNotification, object: nil)
//                        
//                        
//                        //                let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("HomeViewID")
//                        //                self.navigationController!.pushViewController(VC1, animated: true)
//                        
//                    }
//                    else {
//                        print("Can't post to parse")
//                    }
//                }
                
                
                
            }
        })
        return cell
    }
    
    //UICollectionViewDataSource Methods (Remove the "!" on variables in the function prototype)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var count: Int = 0
        if(self.photosAsset != nil){
            count = self.photosAsset.count
        }
        return count;
    }
    
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 4
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
    
    
    
    
    //**************************************************************************************

    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    @IBAction func btnCancel(sender: UIBarButtonItem) {
         self.navigationController?.popToRootViewControllerAnimated(true) //!!Added Optional Chaining
    }
    
    @IBAction func onUpload(sender: AnyObject) {
  
                userData.postUserImage(pdfFile, withCaption: "pdf upload") { (success: Bool, error: NSError?) -> Void in
                    if success {
                        print("Upload succesfully")
                        
                        //erase imageview after succes upload
                        //self.imagePhoto!.image = nil
                        //self.captionField.text = ""
                        
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


