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
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        if let repository,
           let url = URL(string: repository.owner.htmlURL) {
            webView.load( URLRequest(url: url))
        }
    }
}
