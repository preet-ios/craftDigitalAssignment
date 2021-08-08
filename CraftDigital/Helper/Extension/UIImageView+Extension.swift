//
//  UIImageView+Extension.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import UIKit
import Foundation

let cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

  func loadImageWith(url: String?, placeholder: UIImage? = nil) {
    guard let urlString = url,
          let url = URL(string: urlString) else {
      self.image = placeholder
      return
    }

    image = nil
    var activityIndecator: UIActivityIndicatorView!

    if !self.subviews.contains(UIActivityIndicatorView()) {
      activityIndecator = UIActivityIndicatorView(style: .medium)
      activityIndecator.hidesWhenStopped = true
      activityIndecator.startAnimating()
      self.addSubview(activityIndecator)
      activityIndecator.center = self.center
    }

    if let cacheImage = cache.object(forKey: url as AnyObject) as? UIImage {
      self.image = cacheImage
      activityIndecator.isHidden = true
      return
    }

    URLSession.shared.dataTask(with: url) {
      data, response, error in
      if error != nil {
        if (error as? URLError)?.errorCode == -1001 {
          DispatchQueue.main.async {
            activityIndecator.removeFromSuperview()
            activityIndecator.isHidden = true
            self.image = nil
          }
        }
        return
      }
      if let data = data,
         let imageToCache = UIImage(data: data) {
        DispatchQueue.main.async {
          cache.setObject(imageToCache, forKey: url as AnyObject)
          self.image = imageToCache
          activityIndecator.isHidden = true
        }
      } else {
        self.noImageFound(activityIndecator)
      }
    }.resume()
  }
    
    private func noImageFound(_ activityIndecator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
          activityIndecator.removeFromSuperview()
          activityIndecator.isHidden = true
          self.image = UIImage(named: "placeholder")
        }
    }
}
