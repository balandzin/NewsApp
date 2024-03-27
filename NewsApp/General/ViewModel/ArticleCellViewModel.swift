//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let data: String
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        data = article.date
    }
}
