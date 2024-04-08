//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

final class ArticleCellViewModel: TableCollectionViewItemsProtocol {
    let title: String
    let description: String
    var data: String
    let imageUrl: String?
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title ?? ""
        description = article.description ?? ""
        data = article.date
        imageUrl = article.urlToImage ?? ""
        
        if let formatDate = formatDate(dateString: self.data) {
            self.data = formatDate
        }
    }
    
    private func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
