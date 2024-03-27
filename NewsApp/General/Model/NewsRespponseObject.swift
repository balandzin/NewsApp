//
//  NewsRespponseObject.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

struct NewsRespponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
