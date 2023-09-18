//
//  NewsDetailPage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 7.09.2023.
//

import UIKit
import CoreData

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

final class NewsDetailPage: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var savedButton: UIButton!
    
    var newsTitle: String?
    var newsDescription: String?
    var newsDate: String?
    var newsImage: String?
    
    var savedList = [SavedNews]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.cornerRadius = 16

        preparePage()

    }

    private func preparePage() {
        titleLabel.text = newsTitle
        descriptionLabel.text = newsDescription
        dateLabel.text = newsDate
        if let urlToImage = newsImage, let url = URL(string: urlToImage) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    @IBAction func savedButtonAct(_ sender: Any) {
        updateSavedNews(withTitle: newsTitle!)
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
                savedNews.title = newsTitle
                savedNews.urlToImage = newsImage
                savedNews.publishedAt = newsDate
                savedNews.content = newsDescription

                appDelegate.saveContext()
                savedButton.setImage((UIImage(systemName: "bookmark.fill")), for: .normal)
            }
        } catch {
            print(error)
        }
    }
}
