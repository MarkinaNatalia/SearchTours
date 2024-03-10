//
//  ImagesLoader.swift
//  SearchTours
//
//  Created by Наталья on 10.03.2024.
//

import UIKit

protocol ImagesLoaderProtocol {
    func loadImage(urlImage: String, completion: @escaping (UIImage) -> Void) -> UUID?
    func cancelLoad(uuid: UUID)
}

final class ImagesLoader: ImagesLoaderProtocol {
    private var loadedImages = NSCache<NSURL, UIImage>()
    private var runningRequests: [UUID: URLSessionDataTask] = [:]
    private let session = URLSession.shared
    
    func loadImage(urlImage: String, completion: @escaping (UIImage) -> Void) -> UUID? {
        guard let url = URL(string: urlImage) else { return nil }
        
        if let cacheImage = loadedImages.object(forKey: url as NSURL) {
            completion(cacheImage)
            return nil
        }
        
        let uuid = UUID()
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            defer { self.runningRequests.removeValue(forKey: uuid) }
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            self.loadedImages.setObject(image, forKey: url as NSURL)
            completion(image)
            return
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
