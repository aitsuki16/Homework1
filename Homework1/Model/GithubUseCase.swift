//
//  useCase.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import Foundation

class GithubUseCase {
    private let repository: GithubRepository
    
    init(repository: GithubRepository = GithubRepository()) {
        self.repository = repository
    }
    
    func getRepositories(completion: @escaping (Result<[GitHubEntity], Error>) -> Void) {
        repository.fetchRepositories { result in
            completion(result)
        }
    }
}
