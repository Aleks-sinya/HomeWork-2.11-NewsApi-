//
//  NewsTableViewController.swift
//  HomeWork 2.11 (NewsApi)
//
//  Created by Алексей Синяговский on 12.04.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private var news = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.getNewsAlamofire(from: NetworkManager.api) { listNews in
            DispatchQueue.main.async {
                self.news = listNews
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        ) as? NewsTableViewCell ?? NewsTableViewCell.init(
            style: .default,
            reuseIdentifier: ""
        )
        
        setBorder(for: cell)
        setText(for: cell, for: news, and: indexPath)
        setImage(for: cell, for: news, and: indexPath)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let currentNews = self.news[indexPath.row]
        guard let descriptionVC = segue.destination as? DescriptionNewViewController else { return }
        descriptionVC.news = currentNews
    }
    
    // MARK: - Private methods
    private func setBorder(for cell: NewsTableViewCell) {
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = cell.frame.width / 20
        cell.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setText(for cell: NewsTableViewCell, for news: [Articles], and indexPath: IndexPath) {
        let currentNews = news[indexPath.row]
        cell.titleLabel.text = currentNews.title
        cell.shortDescriptionLabel.text = currentNews.description
    }
    
    private func setImage(for cell: NewsTableViewCell, for news: [Articles], and indexPath: IndexPath) {
        let currentNews = news[indexPath.row]
        
        if let image = currentNews.urlToImage {
            DispatchQueue.global().async {
                let image = NetworkManager.getImage(urlImage: image)
                DispatchQueue.main.async {
                    cell.imageNew.image = image
                }
            }
        }
    }
}
