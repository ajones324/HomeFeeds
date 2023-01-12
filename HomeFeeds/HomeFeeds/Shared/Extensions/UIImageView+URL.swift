//
//  UIImageView+URL.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/12/23.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
    
    func loadImageURL(url: URL) {
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        
        HttpClient(session: URLSession.shared).get(url: url) { [unowned self] data, error in
            guard let data = data else {
                return
            }
            guard let imageToCache = UIImage(data: data) else { return }
            imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
