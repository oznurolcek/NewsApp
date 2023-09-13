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
        "https://newsapi.org/v2/everything?q=\(self.categories)&apiKey=\(API_KEY)"
    }
    
    let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareSearchBar()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNews()
        prepareDarkMode()
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
        })
    }
    
    private func prepareDarkMode() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let appDelegate = windowScene?.windows.first
        if darkModeEnabled {
            appDelegate?.overrideUserInterfaceStyle = .dark
        } else {
            appDelegate?.overrideUserInterfaceStyle = .light
        }
    }
    
//    func reloadTableView() -> () -> () {
//        return {
//            DispatchQueue.main.async {
//                self.newsTableView.reloadData()
//            }
//        }
//    }
    @IBAction func openSideMenuAct(_ sender: Any) {
        
    }
}



//MARK: UITableView
extension NewsPage: UITableViewDelegate, UITableViewDataSource, NewsCellProtocol{
    func saveNews(indexPath: IndexPath) {
//        var list : [Article] = []
//
//        list.append(news[indexPath.row])
//        let savedList = UserDefaults.standard
//        savedList.set(list, forKey: "titleList")
//        let titleList = savedList.array(forKey: "titleList") as? [Article] ?? [Article]()
//        print(titleList)
//
//        var imageList: [String] = []
//        if let item = news[indexPath.row].urlToImage {
//            imageList.append(item)
//            let savedList = UserDefaults.standard
//            savedList.set(imageList, forKey: "imageList")
//            let imageList = savedList.array(forKey: "imageList") as? [String] ?? [String]()
//            print(imageList)
//        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

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
        if let newsAuthor = news[indexPath.row].author {
            cell.authorLabel.text = "by \(newsAuthor)"
        }
    
        cell.cellProtocol = self
        cell.indexPath = indexPath
        

    
        return cell

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
