//
//  GitHubResponseModel.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 10.07.2022.
//

import Foundation

struct GitHubElementModel: Codable {
    let type: String
    let encoding: String
    let size: Int
    let name: String
    let path: String
    let content: String
    let sha: String
    let url: String
    let gitURL: String
    let htmlURL: String
    let downloadURL: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case type, encoding, size, name, path, content, sha, url
        case gitURL = "git_url"
        case htmlURL = "html_url"
        case downloadURL = "download_url"
        case links = "_links"
    }
}

struct Links: Codable {
    let git: String?
    let linksSelf, html: String?

    enum CodingKeys: String, CodingKey {
        case git
        case linksSelf = "self"
        case html
    }
}
