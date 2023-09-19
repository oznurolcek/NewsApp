//
//  SideMenu.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 14.09.2023.
//

import UIKit

class SideMenu: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    private var viewModel = SideMenuViewModel()
    
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
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        let category = viewModel.cellForRow(at: indexPath)
        cell.categoryLabel.text = category.rawValue
        cell.categoryImage.image = UIImage(systemName: category.imageName)
        cell.categoryImage.tintColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categories = NewsCategories.allCases[indexPath.row].categoryName
        let storyboard = UIStoryboard(name: "NewsPage", bundle: nil)
                
        if let vc = storyboard.instantiateViewController(withIdentifier: "NewsPage") as? NewsPage {
            
            vc.viewModel.categories = categories
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
