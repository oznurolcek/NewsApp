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
    @IBOutlet weak var savedButton: UIButton!
    
    lazy var viewModel = NewsDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isNewsSaved = viewModel.checkIfNewsIsSaved(withTitle: viewModel.newsTitle!)
        if isNewsSaved {
            savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
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
        let isNewsSaved = viewModel.checkIfNewsIsSaved(withTitle: viewModel.newsTitle!)
        
        if isNewsSaved {
            savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        } else {
            savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        viewModel.updateSavedNews(withTitle: viewModel.newsTitle!)
    }
}



