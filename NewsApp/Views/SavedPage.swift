//
//  SavedPage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 6.09.2023.
//

import UIKit

final class SavedPage: UIViewController {

    @IBOutlet weak var savedTableView: UITableView!
    
    var viewModel = SavedNewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()

    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchSavedList()
        savedTableView.reloadData()
    }
    
    private func prepareTableView() {
        savedTableView.dataSource = self
        savedTableView.delegate = self
    }
    
}

extension SavedPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTableView.dequeueReusableCell(withIdentifier: "SavedNewsCell", for: indexPath) as! SavedNewsCell
        if let urlToImage = viewModel.cellForRow(at: indexPath).urlToImage {
            cell.newsImageView.downloaded(from: urlToImage)
        }
        cell.titleLabel.text = viewModel.cellForRow(at: indexPath).title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NewsDetailPage", bundle: nil)
                
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailPage") as? NewsDetailPage {
            let newsTitle = viewModel.cellForRow(at: indexPath).title
            let newsDescription = viewModel.cellForRow(at: indexPath).content
            let newsDate = viewModel.cellForRow(at: indexPath).publishedAt
            let newsImage = viewModel.cellForRow(at: indexPath).urlToImage
            
            detailVC.viewModel.newsTitle = newsTitle
            detailVC.viewModel.newsDescription = newsDescription
            detailVC.viewModel.newsImage = newsImage
            detailVC.viewModel.newsDate = newsDate
        
            self.navigationController?.pushViewController(detailVC, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
