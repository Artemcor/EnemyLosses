//
//  ContentService.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 10.07.2022.
//

import Foundation

typealias EnemyLossContentSuccess = (_ lossModel: EnemyLoss, _ perssonelModel: Personnel) -> ()

class APIService {
    
    static func getLossData(success: EnemyLossContentSuccess?) {
        
        let group = DispatchGroup()
        var equipmentModel = EnemyLoss()
        
        let equipmentUrlStr = "https://api.github.com/repos/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/contents/data/russia_losses_equipment.json"
        
        let personnelUrlStr = "https://api.github.com/repos/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/contents/data/russia_losses_personnel.json"
        
        guard let equipmentUrl = URL(string: equipmentUrlStr), let personnelUrl = URL(string: personnelUrlStr) else {
            fatalError("Error: Invalid URL.")
        }
        
        let equipmentRequest = URLRequest(url: equipmentUrl)
        let personnelRequest = URLRequest(url: personnelUrl)
                
        let equipmentSession = URLSession.shared.dataTask(with: equipmentRequest) { (data, response, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                fatalError("Error: Data is corrupt.")
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedGitHubData = try decoder.decode(GitHubElementModel.self, from: data)
                
                guard let jsonData = Data(base64Encoded: decodedGitHubData.content, options: .ignoreUnknownCharacters) else {
                    fatalError("Error: Data is corrupt.")
                }
                
                do {
                    let lossModel = try decoder.decode(EnemyLoss.self, from: jsonData)
                    equipmentModel = lossModel
                    group.leave()
                    
                } catch let error  {
                    group.leave()
                    fatalError("Error: \(error.localizedDescription)")
                }
                
            } catch let error {
                group.leave()
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        group.enter()
        equipmentSession.resume()
        group.wait()
        
        URLSession.shared.dataTask(with: personnelRequest) { (data, response, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                fatalError("Error: Data is corrupt.")
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedGitHubData = try decoder.decode(GitHubElementModel.self, from: data)
                
                guard let jsonData = Data(base64Encoded: decodedGitHubData.content, options: .ignoreUnknownCharacters) else {
                    fatalError("Error: Data is corrupt.")
                }
                
                do {
                    let personnelModel = try decoder.decode(Personnel.self, from: jsonData)
                    if let success = success {
                        DispatchQueue.main.async {
                            success(equipmentModel, personnelModel)
                        }
                    }
                    
                } catch let error  {
                    fatalError("Error: \(error.localizedDescription)")
                }
                
            } catch let error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}

