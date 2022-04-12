//
//  New.swift
//  HomeWork 2.11 (NewsApi)
//
//  Created by Алексей Синяговский on 12.04.2022.
//

struct News: Codable {
    let articles: [Articles]?
    
    init(dictionaryNews: [String: Any]) {
        let articles = Articles.getNews(from: dictionaryNews["articles"] as? [[String: Any]] ?? [])
        self.articles = articles
    }
}

struct Articles: Codable {
    var title: String?
    var urlToImage: String?
    var description: String?
    
    init(value: [String: Any]) {
        title = value["title"] as? String ?? ""
        urlToImage = value["urlToImage"] as? String ?? ""
        description = value["description"] as? String ?? ""
    }
    
    static func getNews(from value: [[String: Any]]) -> [Articles] {
        value.compactMap { Articles(value: $0)
        }
    }
}
