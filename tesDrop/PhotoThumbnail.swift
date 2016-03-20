//
//  PhotoThumbnail.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/13/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class PhotoThumbnail: UICollectionViewCell {
    @IBOutlet var imgView : UIImageView!
    
    
    func setThumbnailImage(thumbnailImage: UIImage){
        self.imgView.image = thumbnailImage
    }
}
