//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 6.09.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchNews(url: URL, completion: @escaping (_ articles: [Article]) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data else {
                print("error")
                return
            }
        
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                completion(news.articles ?? [])
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
