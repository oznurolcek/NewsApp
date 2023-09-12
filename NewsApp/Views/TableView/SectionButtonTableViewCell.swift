//
//  SectionButtonsCell.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 6.09.2023.
//

import UIKit

class SectionButtonTableViewCell: UITableViewCell {
    
    var nameArr = ["deneme", "deneme2", "deneme3", "deneme4", "deneme5"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCollectionView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension SectionButtonTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionButtonCollectionViewCell", for: indexPath) as! SectionButtonCollectionViewCell
        cell.sectionButton.titleLabel?.text = nameArr[indexPath.row]
        return cell
    }
    
    
}
