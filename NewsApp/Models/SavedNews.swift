//
//  SavedNews.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 15.09.2023.
//

import Foundation

struct SavedNews {
    let title: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

var savedList: [SavedNews] = []
