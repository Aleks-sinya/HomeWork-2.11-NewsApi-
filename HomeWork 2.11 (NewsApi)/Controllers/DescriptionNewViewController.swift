//
//  DescriptionNewViewController.swift
//  HomeWork 2.11 (NewsApi)
//
//  Created by Алексей Синяговский on 12.04.2022.
//

import UIKit

class DescriptionNewViewController: UIViewController {
    
    @IBOutlet var newImageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    
    var news: Articles!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = news?.description
        setImageFor(news: news, to: newImageView)
        title = news.title
    }
    
    // MARK: - Private methods
    private func setImageFor(news from: Articles, to: UIImageView) {
        if let image = from.urlToImage {
            DispatchQueue.global().async {
                let image = NetworkManager.getImage(urlImage: image)
                DispatchQueue.main.async {
                    to.image = image
                }
            }
        }
    }
}

