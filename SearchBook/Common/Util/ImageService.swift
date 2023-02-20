//
//  ImageService.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import UIKit

final class ImageService {
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            // Helper
            var image: UIImage?

            defer {
                DispatchQueue.main.async {
                    completion(image)
                }
            }

            if let data = data {
                // Create Image from Data
                image = UIImage(data: data)
            }
        }
        dataTask.resume()
        
        return dataTask
    }

}
