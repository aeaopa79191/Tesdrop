//
//  selectPhoto.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/13/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker
import PhotosUI
import Parse

protocol collecTionCellDelegate {
    func userDidSelectedPhotos(userPhoto: UIImageAsset)
}

let reuseIdentifier = "PhotoCell"
let albumName = "tesDrop"            //App specific folder name

class selectPhoto: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var albumFound : Bool = false
    var assetCollection: PHAssetCollection = PHAssetCollection()  //tesDrop folder
    var photosAsset: PHFetchResult!
    var assetThumbnailSize:CGSize!
    
    @IBOutlet var noPhotosLabel: UILabel!
    
    //Actions & Outlets
    @IBAction func btnCamera(sender : AnyObject) {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            //load the camera interface
            let picker : UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
        }else{
            //no camera available
            let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    @IBAction func btnPhotoAlbum(sender : AnyObject) {
//        let picker : UIImagePickerController = UIImagePickerController()
//        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
//        picker.delegate = self
//        picker.allowsEditing = false
//        self.presentViewController(picker, animated: true, completion: nil)
        
        testingView()
    }
    
    
    

    //Custom Phot Library
    func testingView(){
        
      
        
        
        
        let allAssets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        var evenAssetIds = [String]()
        
        allAssets.enumerateObjectsUsingBlock { (asset, idx, stop) -> Void in
            if let asset = asset as? PHAsset where idx % 2 == 0 {
                evenAssetIds.append(asset.localIdentifier)
            }
        }
        
        
        
        let evenAssets = PHAsset.fetchAssetsWithLocalIdentifiers(evenAssetIds, options: nil)
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 6
        //vc.takePhotoIcon = UIImage(named: "chat")

        
        //***** Design *****
        vc.albumButton.tintColor = UIColor.greenColor()
        vc.cancelButton.tintColor = UIColor.redColor()
        vc.doneButton.tintColor = UIColor.purpleColor()
        vc.selectionCharacter = "✓"
        vc.selectionFillColor = UIColor.grayColor()
        vc.selectionStrokeColor = UIColor.yellowColor()
        vc.selectionShadowColor = UIColor.redColor()
        vc.selectionTextAttributes[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        vc.cellsPerRow = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
            switch (verticalSize, horizontalSize) {
            case (.Compact, .Regular): // iPhone5-6 portrait
                return 2
            case (.Compact, .Compact): // iPhone5-6 landscape
                return 2
            case (.Regular, .Regular): // iPad portrait/landscape
                return 3
            default:
                return 2
            }
        }
        
        
        bs_presentImagePickerController(vc, animated: true,
            select: { (asset: PHAsset) -> Void in
                print("Selected: \(asset)")
              
                self.getAssetThumbnail(asset)
                
                
                
                
                
            }, deselect: { (asset: PHAsset) -> Void in
                print("Deselected: \(asset)")
            }, cancel: { (assets: [PHAsset]) -> Void in
                print("Cancel: \(assets)")
            }, finish: { (assets: [PHAsset]) -> Void in
                print("Finish: \(assets)")
            }, completion: nil)
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.synchronous = true
        print("working")
        manager.requestImageForAsset(asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
            
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(thumbnail)
                let assetPlaceholder = createAssetRequest.placeholderForCreatedAsset
                if let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection, assets: self.photosAsset) {
                    albumChangeRequest.addAssets([assetPlaceholder!])
                }
                }, completionHandler: {(success, error)in
                    dispatch_async(dispatch_get_main_queue(), {
                        NSLog("Adding Image to Library -> %@", (success ? "Sucess":"Error!"))
//                        vc.dismissViewControllerAnimated(true, completion: nil)
                    })
            })
            
        })
        return thumbnail
    }
    
    
    
    
    @IBOutlet var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if the folder exists, if not, create it
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            self.albumFound = true
            self.assetCollection = first_Obj as! PHAssetCollection
        }else{
            //Album placeholder for the asset collection, used to reference collection in completion handler
            var albumPlaceholder:PHObjectPlaceholder!
            //create the folder
            NSLog("\nFolder \"%@\" does not exist\nCreating now...", albumName)
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                albumPlaceholder = request.placeholderForCreatedAssetCollection
                },
                completionHandler: {(success:Bool, error:NSError?)in
                    if(success){
                        print("Successfully created folder")
                        self.albumFound = true
                        let collection = PHAssetCollection.fetchAssetCollectionsWithLocalIdentifiers([albumPlaceholder.localIdentifier], options: nil)
                        self.assetCollection = collection.firstObject as! PHAssetCollection
                    }else{
                        print("Error creating folder")
                        self.albumFound = false
                    }
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Get size of the collectionView cell for thumbnail image
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let cellSize = layout.itemSize
            self.assetThumbnailSize = CGSizeMake(cellSize.width, cellSize.height)
        }
        
        //fetch the photos from collection
        self.navigationController?.hidesBarsOnTap = false   //!! Use optional chaining
        self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        
        
        if let photoCnt = self.photosAsset?.count{
            if(photoCnt == 0){
                self.noPhotosLabel.hidden = false
            }else{
                self.noPhotosLabel.hidden = true
            }
        }
        self.collectionView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "viewLargePhoto"){
            if let controller:ViewPhoto = segue.destinationViewController as? ViewPhoto{
                if let cell = sender as? UICollectionViewCell{
                    if let indexPath: NSIndexPath = self.collectionView.indexPathForCell(cell){
                        controller.index = indexPath.item
                        controller.photosAsset = self.photosAsset
                        controller.assetCollection = self.assetCollection
                    }
                }
            }
        }
        
        //Pass data from selectPhoto to Filter page
        if(segue.identifier == "toFilterView"){
            let passThisImageCollection = assetCollection
            let detailViewController = segue.destinationViewController as! Filter
            detailViewController.readyImageCollection = passThisImageCollection
        }
        
        
    }
    

    
    
    //UICollectionViewDataSource Methods (Remove the "!" on variables in the function prototype)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var count: Int = 0
        if(self.photosAsset != nil){
            count = self.photosAsset.count
        }
        return count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell: PhotoThumbnail = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbnail
        
        //Modify the cell
        let asset: PHAsset = self.photosAsset[indexPath.item] as! PHAsset
        
        // Create options for retrieving image (Degrades quality if using .Fast)
        //        let imageOptions = PHImageRequestOptions()
        //        imageOptions.resizeMode = PHImageRequestOptionsResizeMode.Fast
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: self.assetThumbnailSize, contentMode: .AspectFill, options: nil, resultHandler: {(result, info)in
            if let image = result {
                cell.setThumbnailImage(image)
            }
        })
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 4
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
    
    //UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let image: UIImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            //Implement if allowing user to edit the selected image
            //let editedImage = info.objectForKey("UIImagePickerControllerEditedImage") as UIImage

            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), {
                PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                    let assetPlaceholder = createAssetRequest.placeholderForCreatedAsset
                    if let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection, assets: self.photosAsset) {
                        albumChangeRequest.addAssets([assetPlaceholder!])
                    }
                    }, completionHandler: {(success, error)in
                        dispatch_async(dispatch_get_main_queue(), {
                            NSLog("Adding Image to Library -> %@", (success ? "Sucess":"Error!"))
                            picker.dismissViewControllerAnimated(true, completion: nil)
                        })
                })
                
            })
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
 
    
    
    @IBAction func btnDone(sender: UIBarButtonItem) {
        
    }
    

    
    
    
}


