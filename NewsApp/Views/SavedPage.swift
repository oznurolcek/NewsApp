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
    
    private func prepareTableView() {
        savedTableView.dataSource = self
        savedTableView.delegate = self
    }
    
}

extension SavedPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTableView.dequeueReusableCell(withIdentifier: "SavedNewsCell", for: indexPath) as! SavedNewsCell
        return cell
    }
    
    
}
