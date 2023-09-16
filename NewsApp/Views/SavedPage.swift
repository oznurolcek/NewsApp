//
//  SavedPage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 6.09.2023.
//

import UIKit

final class SavedPage: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var savedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        savedTableView.reloadData()
    }
    
    private func prepareTableView() {
        savedTableView.dataSource = self
        savedTableView.delegate = self
    }
    
}

extension SavedPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTableView.dequeueReusableCell(withIdentifier: "SavedNewsCell", for: indexPath) as! SavedNewsCell
        cell.newsImageView.image = UIImage(named: "ic_categories")
        cell.titleLabel.text = savedList[indexPath.row].title
        
        if let urlToImage = savedList[indexPath.row].urlToImage {
            if let url = URL(string: urlToImage) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell.newsImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NewsDetailPage", bundle: nil)
                
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailPage") as? NewsDetailPage {
            let newsTitle = savedList[indexPath.row].title
            let newsDescription = savedList[indexPath.row].content
            let newsDate = savedList[indexPath.row].publishedAt
            let newsImage = savedList[indexPath.row].urlToImage
            
            detailVC.newsTitle = newsTitle
            detailVC.newsDescription = newsDescription
            detailVC.newsImage = newsImage
            detailVC.newsDate = newsDate
            
//            self.navigationController?.pushViewController(detailVC, animated: true)
            detailVC.modalPresentationStyle = .fullScreen
            self.present(detailVC, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
