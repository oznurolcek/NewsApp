//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 16.09.2023.
//

import UIKit

final class NewsDetailViewModel {
    var newsTitle: String?
    var newsDescription: String?
    var newsDate: String?
    var newsImage: String?
    
    init(newsTitle: String?, newsDescription: String?, newsDate: String?, newsImage: String?) {
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
        self.newsDate = newsDate
        self.newsImage = newsImage
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let urlToImage = newsImage, let url = URL(string: urlToImage) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }
}

