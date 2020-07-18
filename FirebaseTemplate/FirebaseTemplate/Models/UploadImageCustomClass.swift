//
//  UploadImageCustomClass.swift
//  FirebaseTemplate
//
//  Created by Huda on 7/17/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import Foundation
import UIKit
import Photos
import Firebase
import FirebaseStorage

class UploadImage {
static func UploadImageAndGetUrl(path : String, _ ImageName: String, ImageView : UIImage,  complation : @escaping (_ user : URL)->() ) {
        
      
//        guard let data = ImageProfile.pngData() else { return  }
    
      guard let data = ImageView.pngData() else {return}
        let storge = Storage.storage().reference()
        let imageRef = storge.child("\(path)/").child("\(ImageName)")
        imageRef.putData(data, metadata: nil) { (meta, eror) in

            imageRef.downloadURL { (url, eror) in
                guard let url = url else {return}
               complation(url)
               
            }
        
        }
        
       
    }


    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
