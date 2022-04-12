//
//  NetworkManager.swift
//  HomeWork 2.11 (NewsApi)
//
//  Created by Алексей Синяговский on 12.04.2022.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let api = "https://newsapi.org/v2/top-headlines?country=cn&apiKey=98c0892451fa47a0b853bcfb44ade68c"
    
//    static let api = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=98c0892451fa47a0b853bcfb44ade68c" Русские новости
    
    private init() {}
    
    
    private func fetchNews(from urlString: String, with completion: @escaping ([Articles]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error { print(error); return }
            if let response = response { print(response); return }
            
            if let data = data {
                if let news = self.parseJSON(data: data),
                   let articles = news.articles {
                    completion(articles)
                }
            }
        }.resume()
    }
    
    private func parseJSON(data: Data) -> News? {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(News.self, from: data)
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    static func getImage(urlImage: String) -> UIImage? {
        guard let imageUrl = URL(string: urlImage) else { return nil }
        guard let imageData = try? Data(contentsOf: imageUrl) else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        return image
    }
    
    static func getNewsAlamofire(from urlString: String, with completion: @escaping ([Articles]) -> Void) {
        AF.request(urlString)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let news = News.init(dictionaryNews: value as? [String: Any] ?? ["": ""])
                    completion(news.articles ?? [])
                case .failure(let error):
                    print(error)
                }
        }
    }
}
