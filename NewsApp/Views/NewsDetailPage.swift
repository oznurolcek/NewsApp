//
//  NewsDetailPage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 7.09.2023.
//

import UIKit
import CoreData

final class NewsDetailPage: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var savedButton: UIButton!
    
    var viewModel = NewsDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePage()

    }

    private func preparePage() {
        imageView.layer.cornerRadius = 16
        titleLabel.text = viewModel.newsTitle
        descriptionLabel.text = viewModel.newsDescription
        dateLabel.text = viewModel.dateFormatter(news: viewModel.newsDate!)
        if let urlToImage = viewModel.newsImage {
            imageView.downloaded(from: urlToImage)
        }
    }
    
    @IBAction func savedButtonAct(_ sender: Any) {
        updateSavedNews(withTitle: viewModel.newsTitle!)
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
                savedButton.setImage((UIImage(systemName: "bookmark")), for: .normal)
            } else {
                defaults.set(true, forKey: "isSaved")
                let savedNews = SavedNews(context: context)
                savedNews.title = viewModel.newsTitle
                savedNews.urlToImage = viewModel.newsImage
                savedNews.publishedAt = viewModel.newsDate
                savedNews.content = viewModel.newsDescription

                appDelegate.saveContext()
                savedButton.setImage((UIImage(systemName: "bookmark.fill")), for: .normal)
            }
        } catch {
            print(error)
        }
    }
}
