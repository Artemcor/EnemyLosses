//
//  LossViewController.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 19.07.2022.
//

import UIKit

class LossViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var lossNumberLabel: UILabel!
    
    // MARK: - Variables
    
    var categoryName = ""
    var categoryValue = ""
    
    // MARK: - Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureOutlets()
        configureController()
    }
    
    // MARK: - Public
    
    func configure(with category: String, and value: String) {
        categoryName = category
        categoryValue = value
    }
    
    // MARK:- Private
    
    private func configureOutlets() {
        categoryNameLabel.text = "\(categoryName.capitalized):"
        lossNumberLabel.text = categoryValue
        
        guard let image = UIImage(named: categoryName) else {
            categoryImage.image = UIImage(named: "default")
            return
        }
        categoryImage.image = image
        
    }
    
    private func configureController() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
