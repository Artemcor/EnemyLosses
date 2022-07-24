//
//  GeneralApplicationCoordinator.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 18.07.2022.
//

import Foundation
import UIKit

class GeneralApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootNVC: UINavigationController
    let router: Router
    let mainCoordinator: MainCoordinator
    
    init(window: UIWindow) {
        self.window = window
        
        rootNVC = UINavigationController()
        router = MainRouter(navigationController: rootNVC)
        mainCoordinator = MainCoordinator(router: router)
        configureNavigatinBar()
    }
    
    func performCoordination() {
        window.rootViewController = rootNVC
        mainCoordinator.performCoordination()
        window.makeKeyAndVisible()
    }
    
    private func configureNavigatinBar() {
        rootNVC.navigationBar.tintColor = UIColor.white
        rootNVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        rootNVC.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        rootNVC.navigationBar.barTintColor = UIColor.systemBlue
    }
    
}
