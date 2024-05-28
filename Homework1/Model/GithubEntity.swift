//
//  GithubEntity.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import Foundation

struct GitHubEntity: Codable {
    let name: String
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case stargazersCount = "stargazers_count"
    }
}

struct GitHubSearchResult: Codable {
    let items: [GitHubEntity]
}
