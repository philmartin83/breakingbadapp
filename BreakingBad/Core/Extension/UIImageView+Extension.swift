//
//  UIImageView+Extension.swift
//  BreakingBad
//
//  Created by Phil Martin on 01/07/2022.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString: String, indicatorColour: UIColor = .white) async {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
       
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: frame.size.width/2, y: frame.size.height/2, width: 0, height: 0))
        addSubview(activityIndicator)
        activityIndicator.color = indicatorColour
        activityIndicator.startAnimating()

        // if not, download image from url
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return image = nil
            }
            activityIndicator.removeFromSuperview()
            switch response.statusCode {
            case 200...299:
                if let image = UIImage(data: data) {
                    self.image = image
                    imageCache.setObject(image, forKey: urlString as NSString)
                }
            case 401:
                image = nil
                return
            default:
                image = nil
                return
            }
        } catch {
            image = nil
            activityIndicator.removeFromSuperview()
            return
        }
    }
}
