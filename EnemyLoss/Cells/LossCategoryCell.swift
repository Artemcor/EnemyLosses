//
//  LossCategoryCell.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 10.07.2022.
//

import UIKit

class LossCategoryCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    // MARK: - Public
    
    func configure(with catagoryName: String) {
        categoryLabel.text = catagoryName.capitalized
        
        guard let image = UIImage(named: catagoryName) else {
            categoryImage.image = UIImage(named: "default")
            return
        }
        categoryImage.image = image
    }
}



