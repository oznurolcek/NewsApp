//
//  ViewController.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

final class NewsPage: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    var news: [Article] = []
    var categories: String = "default"
    
    func getUrl(categories: String) -> String {
        "https://newsapi.org/v2/everything?q=\(self.categories)&apiKey=\(API_KEY)"
    }
    
    let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    
    var isSearch = false
    
    var isMenuOpen: Bool = false
    var beginPoint: CGFloat = 0.0
    var difference: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareSearchBar()
        sideMenuView.isHidden = !isMenuOpen
    
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
        if darkModeEnabled == true {
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
   

//MARK: Side Menu
    func showSideMenu() {
        UIView.animate(withDuration: 0.1, animations: {
            self.sideMenuLeadingConstraint.constant = 10
            self.view.layoutIfNeeded()
        }) { (status) in
            UIView.animate(withDuration: 0.1, animations: {
                self.sideMenuLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }) { (status) in
                self.sideMenuView.isHidden = self.isMenuOpen
                self.isMenuOpen = !self.isMenuOpen
            }
        }
    }
    
    func hideSideMenu() {
        UIView.animate(withDuration: 0.1, animations: {
            self.sideMenuLeadingConstraint.constant = 10
            self.view.layoutIfNeeded()
        }) { (status) in
            UIView.animate(withDuration: 0.1, animations: {
                self.sideMenuLeadingConstraint.constant = -280
                self.view.layoutIfNeeded()
            }) { (status) in
                self.sideMenuView.isHidden = !self.isMenuOpen
                self.isMenuOpen = !self.isMenuOpen
            }
        }
        
    }
    
    @IBAction func openSideMenuAct(_ sender: Any) {
        if !isMenuOpen {
            showSideMenu()
        } else {
            hideSideMenu()
        }
    }
    
    @IBAction func hideSideMenuGestureRecognizer(_ sender: Any) {
        hideSideMenu()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isMenuOpen {
            if let touch = touches.first {
                let location = touch.location(in: sideMenuView)
                beginPoint = location.x
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isMenuOpen {
            if let touch = touches.first {
                let location = touch.location(in: sideMenuView)
                let differenceFromBeginPoint = beginPoint - location.x
                if (differenceFromBeginPoint > 0 && differenceFromBeginPoint < 280) {
                    self.sideMenuLeadingConstraint.constant = -differenceFromBeginPoint
                    difference = differenceFromBeginPoint
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isMenuOpen {
            if touches.first != nil {
                if (difference < 140) {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.sideMenuLeadingConstraint.constant = -290
                    }) { (status) in
                        self.isMenuOpen = false
                        self.sideMenuView.isHidden = !self.isMenuOpen
                    }
                } else {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.sideMenuLeadingConstraint.constant = -10
                    }) { (status) in
                        self.isMenuOpen = true
                        self.sideMenuView.isHidden = !self.isMenuOpen
                    }
                }
            }
        }
    }
}

//MARK: UITableView
extension NewsPage: UITableViewDelegate, UITableViewDataSource, NewsCellProtocol{
    func saveNews(indexPath: IndexPath) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        let selectedNews = news[indexPath.row]

            let savedNews = SavedNews(context: context)
            savedNews.title = selectedNews.title
            savedNews.urlToImage = selectedNews.urlToImage
            savedNews.publishedAt = selectedNews.publishedAt
            savedNews.content = selectedNews.content

        appDelegate.saveContext()
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
            let newsDescription = news[indexPath.row].content
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
        categories = searchText
        if searchText == "" {
            isSearch = false
        } else {
            isSearch = true
        }
        newsTableView.reloadData()
    }
}

class CustomTabBarController: UITabBarController {
    
}
