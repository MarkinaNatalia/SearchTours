//
//  UIImage+Extension.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

extension UIImageView {
    func loadImage(imageUrl: String) {
        UIImagesLoader.shared.load(url: imageUrl, for: self)
    }
    
    func cancelImageLoad() {
        UIImagesLoader.shared.cancel(for: self)
    }
}
