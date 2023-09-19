//
//  SavedNewsViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 18.09.2023.
//

import UIKit

final class SavedNewsViewModel {
    var savedList = [SavedNews]()
    
    func numberOfItems(in section: Int) -> Int {
        return savedList.count
    }

    func cellForRow(at indexPath: IndexPath) -> SavedNews {
        return savedList[indexPath.row]
    }
    
    func fetchSavedList() {
        do {
            savedList = try context.fetch(SavedNews.fetchRequest())
        } catch {
            print(error)
        }
        
    }
}
