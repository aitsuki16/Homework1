//
//  RepositoriesViewController.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let useCase = GithubUseCase()
    private var repositories: [GitHubEntity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: GitHubCell.self),
                                 bundle: nil), forCellReuseIdentifier: String(describing: GitHubCell.self))
        searchBar.delegate = self
    }
    
    private func fetchRepositories(searchQuery: String) {
        useCase.getRepositories(searchQuery: searchQuery) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch repositories: \(error)")
            }
        }
    }
}

extension RepositoriesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        fetchRepositories(searchQuery: query)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            repositories = []
            tableView.reloadData()
        }
    }
}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GitHubCell.self), for: indexPath) as? GitHubCell {
            let repository = repositories[indexPath.row]
            cell.configure(with: repository)
            return cell
        }
        return GitHubCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repository = repositories[indexPath.row]
        let detailVC = RepositoryDetailViewController()
        detailVC.repository = repository
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
