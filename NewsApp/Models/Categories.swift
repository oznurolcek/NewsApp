//
//  Categories.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 12.09.2023.
//

import Foundation

enum NewsCategories: String, CaseIterable {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    var imageName: String {
        switch self {
        case .business:
            return "bag"
        case .entertainment:
            return "figure.socialdance"
        case .general:
            return "globe"
        case .health:
            return "heart"
        case .science:
            return "atom"
        case .sports:
            return "basketball"
        case .technology:
            return "laptopcomputer.and.iphone"
        }
    }
}

