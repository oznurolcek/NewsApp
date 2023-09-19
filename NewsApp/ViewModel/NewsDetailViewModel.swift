//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 16.09.2023.
//

import UIKit

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
}

