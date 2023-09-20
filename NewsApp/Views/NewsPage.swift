//
//  ViewController.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import UIKit
import CoreData

final class NewsPage: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    lazy var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareSearchBar()
        prepareNavBar()
        viewModel.darkMode()
        viewModel.getNews(categories: viewModel.categories)
        viewModel.onSuccess = reloadTableView()
        sideMenuView.isHidden = !viewModel.isMenuOpen
    
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
                self.sideMenuView.isHidden = self.viewModel.isMenuOpen
                self.viewModel.isMenuOpen = !self.viewModel.isMenuOpen
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
                self.sideMenuView.isHidden = !self.viewModel.isMenuOpen
                self.viewModel.isMenuOpen = !self.viewModel.isMenuOpen
            }
        }
    }
    
    @IBAction func openSideMenuAct(_ sender: Any) {
        if !viewModel.isMenuOpen {
            showSideMenu()
        } else {
            hideSideMenu()
        }
    }
    
    @IBAction func hideSideMenuGestureRecognizer(_ sender: Any) {
        hideSideMenu()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if viewModel.isMenuOpen {
            if let touch = touches.first {
                let location = touch.location(in: sideMenuView)
                viewModel.beginPoint = location.x
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if viewModel.isMenuOpen {
            if let touch = touches.first {
                let location = touch.location(in: sideMenuView)
                let differenceFromBeginPoint = viewModel.beginPoint - location.x
                if (differenceFromBeginPoint > 0 && differenceFromBeginPoint < 280) {
                    self.sideMenuLeadingConstraint.constant = -differenceFromBeginPoint
                    viewModel.difference = differenceFromBeginPoint
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if viewModel.isMenuOpen {
            if touches.first != nil {
                if (viewModel.difference < 140) {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.sideMenuLeadingConstraint.constant = -290
                    }) { (status) in
                        self.viewModel.isMenuOpen = false
                        self.sideMenuView.isHidden = !self.viewModel.isMenuOpen
                    }
                } else {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.sideMenuLeadingConstraint.constant = -10
                    }) { (status) in
                        self.viewModel.isMenuOpen = true
                        self.sideMenuView.isHidden = !self.viewModel.isMenuOpen
                    }
                }
            }
        }
    }
}

//MARK: UITableView
extension NewsPage: UITableViewDelegate, UITableViewDataSource, NewsCellProtocol{
    func saveNews(indexPath: IndexPath) {
        
        viewModel.saveNews(indexPath: indexPath)
        
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
