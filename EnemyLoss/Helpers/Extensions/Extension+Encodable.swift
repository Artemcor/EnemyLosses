//
//  Extension+Encodable.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 20.07.2022.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}


