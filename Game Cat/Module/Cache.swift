//
//  Cache.swift
//  Game Cat
//
//  Created by Davin Djayadi on 21/09/22.
//

import UIKit

struct Cache {
    private static let imageCache: NSCache<NSString, UIImage> = NSCache()
    
    static func isImageCached(key: NSString) -> Bool {
        return imageCache.object(forKey: key) != nil
    }
    static func getImageCache(key: NSString) -> UIImage {
        return imageCache.object(forKey: key)!
    }
    static func setImageCache(key: NSString, image: UIImage) {
        imageCache.setObject(image, forKey: key)
    }
}
