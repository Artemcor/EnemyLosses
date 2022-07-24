//
//  MainCoordinator.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 18.07.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    private struct Constants {
        struct Storyboard {
            struct Identifier{
                static let lossCategoryViewController = "LossCategoryViewController"
                static let lossViewController = "LossViewController"
            }
        }
    }
    
    // MARK: - Variables
    
    private let router: Router
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    // MARK: - Init
    
    init(router: Router) {
        self.router = router
    }
    
    func performCoordination() {
        getEnemyLossContent()
    }
    
    
    // MARK: - Requests managers
    
    private func getEnemyLossContent() {
        APIService.getLossData { lossModel, personnelModel in
            self.loadLossCategoryController(with: lossModel, and: personnelModel)
        }
    }
    
    private func loadLossCategoryController(with equipmentModel: EnemyLoss, and personnelModel: Personnel) {
        guard let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.Identifier.lossCategoryViewController) as? LossCategoryViewController else {
            fatalError("Error - LossCategoryViewController not loaded")
        }
        
        controller.delegate = self
        controller.configure(with: equipmentModel, and: personnelModel)
        
        router.push(controller, animated: true)
    }
    
    private func loadLossController(with category: String, and value: String) {
        guard let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.Identifier.lossViewController) as? LossViewController else {
            fatalError("Error - LossViewController not loaded")
        }
        
        controller.configure(with: category, and: value)
        
        router.push(controller, animated: true)
    }
}

// MARK: - LossCategoryControllerDelegate

extension MainCoordinator: LossCategoryControllerDelegate {
    
    func rowWasClicked(with catagory: String, and value: String) {
        loadLossController(with: catagory, and: value)
    }
    
    

    
    
}
