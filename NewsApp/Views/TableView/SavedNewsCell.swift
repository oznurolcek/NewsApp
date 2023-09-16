//
//  SavedNewsCell.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 8.09.2023.
//

import UIKit

class SavedNewsCell: UITableViewCell {

    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleBackView.layer.cornerRadius = 16
        newsImageView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
