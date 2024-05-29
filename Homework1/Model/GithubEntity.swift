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
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case name
        case stargazersCount = "stargazers_count"
        case owner
    }
}

struct Owner: Codable {
    let login: String
    let htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case htmlURL = "html_url"
    }
}

struct GitHubSearchResult: Codable {
    let items: [GitHubEntity]
}
