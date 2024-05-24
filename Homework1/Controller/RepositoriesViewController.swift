//
//  RepositoriesViewController.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    
    override func viewDidLoad() {

        return
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
                
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GitHubCell.self), for: indexPath) as? GitHubCell {
            return cell
        }
        return GitHubCell()
    }

}
