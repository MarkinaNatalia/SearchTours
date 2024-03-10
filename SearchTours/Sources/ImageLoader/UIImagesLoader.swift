//
//  UIImagesLoader.swift
//  SearchTours
//
//  Created by Наталья on 10.03.2024.
//

import UIKit

protocol UIImagesLoaderProtocol {
    func load(url: String, for imageView: UIImageView)
    func cancel(for imageView: UIImageView)
}

final class UIImagesLoader: UIImagesLoaderProtocol {
    static let shared = UIImagesLoader()
    
    private let imagesLoader = ImagesLoader()
    private var uuidMap: [UIImageView: UUID] = [:]
    
    func load(url: String, for imageView: UIImageView) {
        let uuid = imagesLoader.loadImage(urlImage: url) { [weak self] image in
            guard let self = self else { return }
            
            defer { self.uuidMap.removeValue(forKey: imageView) }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        guard let uuid = uuid else { return }
        uuidMap[imageView] = uuid
    }
    
    func cancel(for imageView: UIImageView) {
        guard let uuid = uuidMap[imageView] else { return }
        imagesLoader.cancelLoad(uuid: uuid)
        uuidMap.removeValue(forKey: imageView)
    }
}
