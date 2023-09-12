//
//  News.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 7.09.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? JSONDecoder().decode(News.self, from: jsonData)

import Foundation

// MARK: - News
struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

//class News {
//    var id: Int?
//    var title: String?
//    var description: String?
//    var imageName: String?
//
//    init(id: Int, title: String, description: String, imageName: String) {
//        self.id = id
//        self.title = title
//        self.description = description
//        self.imageName = imageName
//    }
//}
//
//let news: [News] = [
//    News(id: 1, title: "Mexico’s Supreme Court Decriminalizes Abortion Nationwide", description: "The decision builds on an earlier high court ruling and reflects how Latin American countries are expanding reproductive rights.", imageName: "image"),
//    News(id: 2, title: "Bedtime Check-Ins and Crass Remarks: Life in Spanish Women’s Soccer", description: "The comments came after Huawei Technologies introduced the Mate 60 Pro, a Chinese smartphone powered by an advanced chip that is believed to have been made by SMIC. Last week’s launch shocked industry experts who didn’t understand how SMIC, which is headquartered in Shanghai, would have the ability to manufacture such a chip following sweeping efforts by the United States to restrict China’s access to foreign chip technology. TechInsights, a research organization based in Canada specializing in semiconductors, revealed shortly after the launch that the smartphone contained a new 5G Kirin 9000s processor developed specifically for Huawei by SMIC. This is a “big tech breakthrough for China,” Jefferies analysts said Tuesday in a research note. The development has fueled fears among analysts that the US-China tech war is likely to accelerate in the near future. US representative Mike Gallagher, chair of the US House of Representatives committee on China, called on the US Commerce Department on Wednesday to end all technology exports to Huawei and SMIC, according to Reuters. Gallagher was quoted as saying SMIC may have violated US sanctions, as this chip likely could not be produced without US technology. The time has come to end all US technology exports to both Huawei and SMIC to make clear any firm that flouts US law and undermines our national security will be cut off from our technology, he said. Shares in SMIC, which stands for Semiconductor Manufacturing International Corporation, sank 8.3% in Shanghai and 7.6% in Hong Kong on Thursday. Hua Hong Semiconductor, China’s second largest chip foundry, tumbled 5.8%.", imageName: "image2"),
//    News(id: 3, title: "Burning Man’s Muddy Aftermath: A Desert Full of ‘Moop’", description: "Cleaning up after the festival is always a challenge, but this year the trash is soaked with mud and trapped in hardening sludge.", imageName: "image3"),
//    News(id: 4, title: "Extreme Rains Cause Flooding in Bulgaria, Greece and Turkey, Killing 14", description: "The floodwaters ravaged bridges, stranded tourists and swept away cars and buildings. Thousands of households were still cut off from power on Wednesday.", imageName: "image4"),
//    News(id: 5, title: "Biden Administration Moves to Bar Drilling on Millions of Acres in Alaska", description: "The administration will cancel oil and gas leases in the Arctic National Wildlife Refuge and set aside more than half of the National Petroleum Reserve.", imageName: "image5"),
//    News(id: 6, title: "His Mind Helped Rebuild New York. His Body Is Failing Him", description: "Dan Doctoroff’s efforts to rebuild the city after 9/11 brought him power. A terrible diagnosis brought him peace.", imageName: "image6")
//
//]
