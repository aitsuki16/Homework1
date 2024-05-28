//
//  GithubRepository.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import Foundation

class GithubRepository {
    private let apiClient: GitHubApiClient
    
    init(apiClient: GitHubApiClient = GitHubApiClient()) {
        self.apiClient = apiClient
    }
    
    func fetchRepositories(completion: @escaping( Result<[GitHubEntity], Error>) -> Void) {
        apiClient.getRepositories { result in
            switch result {
            case .success(let entities):
                completion(.success(entities))
                           case .failure(let error):
                            completion(.failure(error))
            }
            
        }
    }
}

