//
//  RepositoriesViewController.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    private let useCase = GithubUseCase()
    private var repositories: [GitHubEntity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GitHubCell", bundle: nil), forCellReuseIdentifier: String(describing: GitHubCell.self))
        
        fetchRepositories()
    }
    
    private func fetchRepositories() {
        useCase.getRepositories { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetcg repositories: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repositories.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GitHubCell.self), for: indexPath) as? GitHubCell {
            let repository = repositories[indexPath.row]
            cell.repositoryName.text = repository.name
            cell.stars.text = "\(repository.stargazersCount)"
            return cell
        }
        return GitHubCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let detailVC = RepositoryDetailViewController()
        detailVC.repository = repository
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
