//
//  SideMenuViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 18.09.2023.
//

import UIKit

final class SideMenuViewModel {
    private var categories: [NewsCategories] = NewsCategories.allCases

    func numberOfItems(in section: Int) -> Int {
        return categories.count
    }

    func cellForRow(at indexPath: IndexPath) -> NewsCategories {
        return categories[indexPath.row]
    }
}
