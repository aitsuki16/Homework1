//
//  RepositoryDetailViewController.swift
//  Homework1
//
//  Created by user on 2024/05/24.
//

import UIKit
import WebKit

class RepositoryDetailViewController: UIViewController {
    
    var repository: GitHubEntity?
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.bounds)
               webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               self.view.addSubview(webView)
               
               if let repository = repository {
                   let urlString = "https://github.com/\(repository.name)"
                   if let url = URL(string: urlString) {
                       let request = URLRequest(url: url)
                       webView.load(request) 
                   }
        }
    }
}
