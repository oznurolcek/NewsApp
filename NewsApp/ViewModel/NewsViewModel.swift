//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 10.09.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

final class NewsViewModel {
    var onSuccess: (() -> ())?
    var news: [Article] = []
    var categories: String = "default"
    var isMenuOpen: Bool = false
    var beginPoint: CGFloat = 0.0
    var difference: CGFloat = 0.0
    
    var newsTitle: String?
    var newsDescription: String?
    var newsDate: String?
    var newsImage: String?
    
    func getNews(categories: String) {
        if let url = URL(string: "https://newsapi.org/v2/everything?q=\(categories)&apiKey=\(API_KEY)") {
            NetworkManager.shared.fetchNews(url: url, completion: { news in
                self.news = news
                self.onSuccess?()
            })
        }
    }
    
    func cellForRow(at indexPath: IndexPath) -> Article? {
        return news[indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int {
        return news.count
    }
    
    func darkMode() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let appDelegate = windowScene?.windows.first
        if defaults.bool(forKey: "darkModeEnabled"){
            appDelegate?.overrideUserInterfaceStyle = .dark
        } else {
            appDelegate?.overrideUserInterfaceStyle = .light
        }
    }
    
    func saveNews(indexPath: IndexPath) {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title == %@", cellForRow(at: indexPath)?.title ?? "")
            
            do {
                let existingNews = try context.fetch(fetchRequest)
                
                if let newsToDelete = existingNews.first {
                    defaults.set(false, forKey: "isSaved")
                    context.delete(newsToDelete)
                    appDelegate.saveContext()
                    
                } else {
                    defaults.set(true, forKey: "isSaved")
                    let savedNews = SavedNews(context: context)
                    savedNews.title = cellForRow(at: indexPath)?.title
                    savedNews.urlToImage = cellForRow(at: indexPath)?.urlToImage
                    savedNews.publishedAt = cellForRow(at: indexPath)?.publishedAt
                    savedNews.content = cellForRow(at: indexPath)?.description
                    
                    appDelegate.saveContext()
                }
            } catch {
                print(error)
            }
        }
}
