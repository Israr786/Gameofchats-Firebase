//
//  Helper.swift
//  gameofchats
//
//  Created by Apple on 5/3/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    
    
    func loadImageUsingCacheWithStringUrl(urlString:String){
      //  if let profileImageUrl = user.profileImageUrl {
        //check for cache image
        self.image = nil
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        
        
        let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, err) in
                if(err != nil){
                    print(err)
                }
                DispatchQueue.main.async {
                    //       cell.imageView?.image = UIImage(data: data!)
                 if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                    }
                    
                    
               //     self.image = UIImage(data: data!)
                }
                
        }).resume()
    }

}
