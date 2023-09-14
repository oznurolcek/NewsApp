//
//  SideMenu.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 14.09.2023.
//

import UIKit

class SideMenu: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareTableView()
    }
    
    private func prepareTableView() {
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
    }
    
}

extension SideMenu: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsCategories.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.categoryLabel.text = NewsCategories.allCases[indexPath.row].rawValue
        cell.categoryImage.image = UIImage(systemName: NewsCategories.allCases[indexPath.row].imageName)
        cell.categoryImage.tintColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categories = NewsCategories.allCases[indexPath.row].categoryName
        let storyboard = UIStoryboard(name: "NewsPage", bundle: nil)
                
        if let vc = storyboard.instantiateViewController(withIdentifier: "NewsPage") as? NewsPage {
            
            vc.categories = categories
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
