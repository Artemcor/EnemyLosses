//
//  PersonnelLossModel.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 21.07.2022.
//

import Foundation

struct PersonnelElement: Codable {
    let date: String
    let day: Int
    let personnel: Int
    let pow: Int?

    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case pow = "POW"
    }
}

typealias Personnel = [PersonnelElement]
