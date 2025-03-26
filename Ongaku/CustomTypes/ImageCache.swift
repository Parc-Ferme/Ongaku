//
//  ImageCache.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

class ImageCache {

  private var cache: NSCache<NSString, UIImage> = NSCache()

  init() {
    NotificationCenter.default.addObserver(
      forName: UIApplication.didReceiveMemoryWarningNotification,
      object: nil,
      queue: .main) { _ in

        self.cache.removeAllObjects()
      }
  }

  deinit {
          NotificationCenter.default.removeObserver(self)
  }

  func get(forKey key: String) -> UIImage? {

    return cache.object(forKey: key as NSString)
  }

  func set(forKey key: String, image: UIImage) -> Void {

    cache.setObject(image, forKey: key as NSString)
  }

  func delete(forKey key: String) -> Void {

    cache.removeObject(forKey: key as NSString)
  }

  func deleteAll() -> Void {

    cache.removeAllObjects()
  }
}

extension ImageCache {

  private static var imageCache: ImageCache = ImageCache()

  static func getImageCache() -> ImageCache {

    return imageCache
  }

  static func deleteImageCache(imageURL: String) -> Void {

    imageCache.delete(forKey: imageURL)
  }

  static func CleanCache() -> Void {

    imageCache.deleteAll()
  }

}
