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
    let data: String
    let imageUrl: String?
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title ?? ""
        description = article.description ?? ""
        data = article.date ?? ""
        imageUrl = article.urlToImage ?? ""
    }
}
