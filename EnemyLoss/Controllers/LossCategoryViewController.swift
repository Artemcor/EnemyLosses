//
//  LossCategoryViewController.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 10.07.2022.
//

import UIKit

protocol LossCategoryControllerDelegate: AnyObject {
    func rowWasClicked(with catagory: String, and value: String)
}

class LossCategoryViewController: UIViewController {
    
    private struct Constants {
        
        struct TableView {
            struct CellIdentifiers {
                static let lossCategoryCell = "LossCategoryCell"
            }
        }
    }
    
    weak var delegate: LossCategoryControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var categoryTableView: UITableView!
    
    // MARK: - Variables
    
    var equipmentModel = EnemyLoss()
    var personnelModel = Personnel()
    var equipmentModelDict = [String: String]()
    var personnelModelDict = [String: String]()
    var categoryModel = [String]()
    var date = ""
    
    // MARK: - Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
    }
    
    // MARK: - Public
    
    func configure(with equipmentModel: EnemyLoss, and personnelModel: Personnel) {
        self.equipmentModel = equipmentModel
        self.personnelModel = personnelModel
        
        do {
            let equipmentModel = try equipmentModel.last.asDictionary()
            equipmentModelDict = equipmentModel.mapValues { values in
                if values is Int {
                    return String(values as! Int)
                }
                return values as! String
            }
            
            equipmentModel.forEach({
                self.categoryModel.append($0.key)
            })
            
            let personnelModel = try personnelModel.last.asDictionary()
            personnelModelDict = personnelModel.mapValues { values in
                if values is Int {
                    return String(values as! Int)
                }
                return values as! String
            }
            
            equipmentModelDict += personnelModelDict
            
            personnelModel.forEach({
                self.categoryModel.append($0.key)
            })
            
            date = personnelModel["date"] as! String
            
            categoryModel = categoryModel.filter { $0 != "day" && $0 != "date" }.sorted(by: { $0.lowercased() < $1.lowercased() } )
                
        } catch {
            fatalError("Error: Model creation was not complete")
        }
    }
   
    // MARK: - Private
    
    private func configureController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.prompt = date
    }
}

// MARK: - LossCatagoryTableView Delegets

extension LossCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.CellIdentifiers.lossCategoryCell, for: indexPath) as? LossCategoryCell else {
            fatalError("Error: LossCategoryCell not dequeue")
        }
        
        let catagoryName = categoryModel[indexPath.row]
        cell.configure(with: catagoryName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categoryModel[indexPath.row]
        guard let value = equipmentModelDict[category] else {
            fatalError("Error: Key was not found")
        }
        delegate?.rowWasClicked(with: category, and: value)
    }
}

