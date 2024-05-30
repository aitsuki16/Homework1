//
//  GitHubApiClient.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import Foundation

class GitHubApiClient {
    struct APIConstants {
        static let baseURL = "https://api.github.com"
        static let searchPath = "/search/repositories"
    }
    
    func getRepositories(searchQuery: String, completion:@escaping (Result<[GitHubEntity],Error>) -> Void) {
        var components = URLComponents(string: APIConstants.baseURL)
        components?.path = APIConstants.searchPath
        components?.queryItems = [URLQueryItem(name: "q", value: searchQuery)]
        guard let url = components?.url else {
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
