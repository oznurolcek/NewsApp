//
//  ViewController.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import UIKit
import CoreData

protocol NewsPageProtocol: AnyObject {
    
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate

final class NewsPage: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    var viewModel = NewsViewModel()
    
    var isSearch = false
    
    var isMenuOpen: Bool = false
    var beginPoint: CGFloat = 0.0
    var difference: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareSearchBar()
        viewModel.darkMode()
        prepareNavBar()
        viewModel.getNews(categories: viewModel.categories)
        viewModel.onSuccess = reloadTableView()
        sideMenuView.isHidden = !isMenuOpen
    
    }
    
    private func prepareTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    private func prepareSearchBar() {
        searchBar.delegate = self
    }
    
    private func prepareNavBar() {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 40))
             let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 40))
             imageView.contentMode = .scaleAspectFit
             let image = UIImage(named: "logo")
             imageView.image = image
             logoContainer.addSubview(imageView)
             navigationItem.titleView = logoContainer
    }
    
    func reloadTableView() -> () -> () {
        return {
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
    }
   

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
        
        let fetchRequest: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", (viewModel.cellForRow(at: indexPath)?.title)!)
        
        do {
            let existingNews = try context.fetch(fetchRequest)
            
            if let newsToDelete = existingNews.first {
                defaults.set(false, forKey: "isSaved")
                context.delete(newsToDelete)
                appDelegate.saveContext()
                
            } else {
                defaults.set(true, forKey: "isSaved")
                let savedNews = SavedNews(context: context)
                savedNews.title = viewModel.cellForRow(at: indexPath)?.title
                savedNews.urlToImage = viewModel.cellForRow(at: indexPath)?.urlToImage
                savedNews.publishedAt = viewModel.cellForRow(at: indexPath)?.publishedAt
                savedNews.content = viewModel.cellForRow(at: indexPath)?.description

                appDelegate.saveContext()
               
            }
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        if let urlToImage = viewModel.cellForRow(at: indexPath)?.urlToImage {
            cell.newsImage.downloaded(from: urlToImage)
        }
        cell.titleLabel.text = viewModel.cellForRow(at: indexPath)?.title
        cell.descriptionLabel.text = viewModel.cellForRow(at: indexPath)?.description
        if let newsAuthor = viewModel.cellForRow(at: indexPath)?.author {
            cell.authorLabel.text = "by \(newsAuthor)"
        }
    
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NewsDetailPage", bundle: nil)
                
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailPage") as? NewsDetailPage {
            let newsTitle = viewModel.cellForRow(at: indexPath)?.title
            let newsDescription = viewModel.cellForRow(at: indexPath)?.content
            let newsDate = viewModel.cellForRow(at: indexPath)?.publishedAt
            let newsImage = viewModel.cellForRow(at: indexPath)?.urlToImage
            
            detailVC.viewModel.newsTitle = newsTitle
            detailVC.viewModel.newsDescription = newsDescription
            detailVC.viewModel.newsImage = newsImage
            detailVC.viewModel.newsDate = newsDate
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

//MARK: UISearchBar
extension NewsPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getNews(categories: searchText)
        if searchText == "" {
            viewModel.getNews(categories: viewModel.categories)
        }
    }
}

class CustomTabBarController: UITabBarController {
    
}
