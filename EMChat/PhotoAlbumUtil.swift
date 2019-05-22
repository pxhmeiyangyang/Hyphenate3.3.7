//
//  PhotoAlbumUtil.swift
//  EMChat
//
//  Created by pxh on 2019/5/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import Photos

/// 相册工具类
class PhotoAlbumUtil: NSObject {

    
    /// 保存图片到相册
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - albumName: 专辑名称
    ///   - completionHandler: 完成回调
    class func saveImage(image: UIImage,albumName: String, completionHandler: @escaping(_ error: Error?)->()){
        //1、获取相册对象
        let library = PHPhotoLibrary.shared()
        //2、判断是否有相册 没有创建相册
        guard let collection = self.photoCollection(name: albumName) else {
            //创建相册
            library.performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
            }) { (isSuccess, error) in
                if let _ = error{
                    self.saveImage(image: image, albumName: albumName, completionHandler: { (error) in
                        completionHandler(error)
                    })
                }else{
                    completionHandler(error)
                }
            }
            return
        }
        //2、保存图片到相册
        library.performChanges({
            let result = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let assetPlaceholder = result.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest.init(for: collection)
            albumChangeRequest?.addAssets([assetPlaceholder] as NSFastEnumeration)
        }) { (isSuccess, error) in
            completionHandler(error)
        }
    }
    
    
    
    
    
    
    
    
    
    /// 根据名称获取相册
    ///
    /// - Parameter name: 相册名称
    /// - Returns: 根据相册名称获取的相册对象
    class func photoCollection(name: String)->PHAssetCollection?{
        var returnAlbum: PHAssetCollection? = nil
        /// 1、创建搜索合集
        let result = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        result.enumerateObjects { (album, index, stop) in
            if name == album.localizedTitle{
                returnAlbum = album
                stop.initialize(to: true)
            }
        }
        return returnAlbum
    }
    
}
