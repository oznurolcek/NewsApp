//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 16.09.2023.
//

import UIKit
import CoreData

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

final class NewsDetailViewModel {
    var newsTitle: String?
    var newsDescription: String?
    var newsDate: String?
    var newsImage: String?
    var savedList = [SavedNews]()
        
    func dateFormatter(news: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            if let date = dateFormatter.date(from: newsDate!) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "dd.MM.yyyy"

                let formattedDate = outputDateFormatter.string(from: date)
                return formattedDate
            }
        return ""
    }
    
    func updateSavedNews(withTitle title: String) {
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let existingNews = try context.fetch(fetchRequest)
            
            if let newsToDelete = existingNews.first {
                defaults.set(false, forKey: "isSaved")
                context.delete(newsToDelete)
                appDelegate.saveContext()
            } else {
                defaults.set(true, forKey: "isSaved")
                let savedNews = SavedNews(context: context)
                savedNews.title = newsTitle
                savedNews.urlToImage = newsImage
                savedNews.publishedAt = newsDate
                savedNews.content = newsDescription

                appDelegate.saveContext()
            }
        } catch {
            print(error)
        }
    }
    
    func checkIfNewsIsSaved(withTitle title: String) -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let existingNews = try context.fetch(fetchRequest)
            return !existingNews.isEmpty
        } catch {
            print(error)
            return false
        }
    }
}

