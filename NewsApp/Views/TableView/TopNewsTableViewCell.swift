//
//  TopNewsTableViewCell.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 7.09.2023.
//

import UIKit

//class TopNewsTableViewCell: UITableViewCell {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        prepareCollectionView()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    func prepareCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//
//}
//
//extension TopNewsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopNewsCollectionViewCell", for: indexPath) as! TopNewsCollectionViewCell
//        cell.imageView.image = UIImage(named: news[indexPath.row].urlToImage)
//        cell.titleLabel.text = news[indexPath.row].title
//        return cell
//        
//    }
//    
//    
//}
