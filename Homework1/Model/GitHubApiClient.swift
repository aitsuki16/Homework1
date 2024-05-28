//
//  GitHubApiClient.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import Foundation

class GitHubApiClient {
    private let baseURL: URL?
    
    init() {
        self.baseURL = URL(string: "https://api.github.com/search/repositories?q=jquery+in:name")
    }
    
    func getRepositories(completion:@escaping (Result<[GitHubEntity],Error>) -> Void) {
        guard let url = baseURL else {
            completion(.failure(NSError(domain: "invalid URL", code: -1, userInfo: nil)))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodeResponse = try JSONDecoder().decode(GitHubSearchResult.self, from: data)
                completion(.success(decodeResponse.items))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
