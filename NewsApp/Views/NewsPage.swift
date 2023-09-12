//
//  ViewController.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import UIKit

final class NewsPage: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var news: [Article] = []
    var categories: String = "default"
    
    func getUrl(categories: String) -> String {
        "https://newsapi.org/v2/everything?q=\(self.categories)&apiKey=7ddc787d735349eea089f6510a1db7e3"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareSearchBar()
        getNews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        
    }
    
    
    private func prepareTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    private func prepareSearchBar() {
        searchBar.delegate = self
    }
    
    func getNews() {
        NetworkManager.shared.fetchNews(url: URL(string: getUrl(categories: categories))!, completion: { news in
            self.news = news
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
            print(self.news.count)
        })
    }
    
//    func reloadTableView() -> () -> () {
//        return {
//            DispatchQueue.main.async {
//                self.newsTableView.reloadData()
//            }
//        }
//    }
}

//MARK: UITableView
extension NewsPage: UITableViewDelegate, UITableViewDataSource, NewsCellProtocol{
    func saveNews(indexPath: IndexPath) {
        print("id: \(news[indexPath.row].url!)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        switch indexPath.row {
//        case 0:
//            let cell = newsTableView.dequeueReusableCell(withIdentifier: "SectionButtonTableViewCell", for: indexPath) as! SectionButtonTableViewCell
//            return cell
//        default:
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            if let urlToImage = news[indexPath.row].urlToImage {
                if let url = URL(string: urlToImage) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                cell.newsImage.image = UIImage(data: data)
                            }
                        }
                    }
                }
            }
            cell.titleLabel.text = news[indexPath.row].title
            cell.descriptionLabel.text = news[indexPath.row].description
            
            cell.cellProtocol = self
            cell.indexPath = indexPath
        
            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NewsDetailPage", bundle: nil)
                
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailPage") as? NewsDetailPage {
            let newsTitle = news[indexPath.row].title
            let newsDescription = news[indexPath.row].description
            let newsDate = news[indexPath.row].publishedAt
            let newsImage = news[indexPath.row].urlToImage
            
            detailVC.newsTitle = newsTitle
            detailVC.newsDescription = newsDescription
            detailVC.newsImage = newsImage
            detailVC.newsDate = newsDate
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

//MARK: UISearchBar
extension NewsPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

class CustomTabBarController: UITabBarController {
    
}
