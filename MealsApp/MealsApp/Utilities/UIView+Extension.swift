//
//  UIView+Extension.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//


import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(urlStr: String) {
        
        image = UIImage()
        
        if let img = imageCache.object(forKey: NSString(string: urlStr)) {
            image = img
            return
        }
        
        guard let url = URL(string: urlStr) else {
            self.image = UIImage(named: "UnvailablePhoto")
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                debugPrint(error)
            } else {
                DispatchQueue.main.async {
                    guard let data = data,
                          let tempImg = UIImage(data: data) else { return }
                    self.alpha = 0.3
                    self.image = tempImg
                    UIView.animate(withDuration: 1.5, animations: {
                        self.alpha = 1.5
                    })
                    imageCache.setObject(tempImg, forKey: NSString(string: urlStr))
                }
            }
        }).resume()
    }
}
