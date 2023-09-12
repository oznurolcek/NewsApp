//
//  NewsDetailPage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 7.09.2023.
//

import UIKit

final class NewsDetailPage: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var newsTitle: String?
    var newsDescription: String?
    var newsDate: String?
    var newsImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 16
        
        preparePage()

    }
    
    private func preparePage() {
        titleLabel.text = newsTitle
        descriptionLabel.text = newsDescription
        dateLabel.text = newsDate
        if let urlToImage = newsImage {
            if let url = URL(string: urlToImage) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
}
