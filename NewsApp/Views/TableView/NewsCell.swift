//
//  NewsCell.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 7.09.2023.
//

import UIKit

protocol NewsCellProtocol {
    func saveNews(indexPath: IndexPath)
}

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var view: UIView!
    
    var cellProtocol: NewsCellProtocol?
    var indexPath: IndexPath?
    
    var isSaved: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 16
        view.layer.cornerRadius = 16
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func savedButtonAct(_ sender: Any) {
        isSaved = !isSaved
        cellProtocol?.saveNews(indexPath: indexPath!)
        if isSaved {
            savedButton.setImage((UIImage(systemName: "bookmark.fill")), for: .normal)
        } else {
            savedButton.setImage((UIImage(systemName: "bookmark")), for: .normal)
        }
        
        
    }
    
}
