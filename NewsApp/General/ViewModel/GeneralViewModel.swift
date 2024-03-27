//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadData: (() -> Void)?
    
    // MARK: - Properties
    var numberOfCells: Int {
        articles.count
    }
    private var articles: [ArticleResponseObject] = [] {
        didSet {
            reloadData?()
        }
    }
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        let article = articles[row]
        return ArticleCellViewModel(article: article)
    }
    
    private func loadData() {
        // TODO: - Load data
        
        setupMockObjects()
    }
    
    private func setupMockObjects() {
        articles = [
            ArticleResponseObject.init(title: "First object", description: "First description", urlToImage: "...", publishedAt: "27.03.2024"),
            ArticleResponseObject.init(title: "Second object", description: "Second description", urlToImage: "...", publishedAt: "27.03.2024"),
            ArticleResponseObject.init(title: "Third object", description: "Third description", urlToImage: "...", publishedAt: "27.03.2024"),
            ArticleResponseObject.init(title: "Fourth object", description: "Fourth description", urlToImage: "...", publishedAt: "27.03.2024"),
            ArticleResponseObject.init(title: "Fifth object", description: "Fifth description", urlToImage: "...", publishedAt: "27.03.2024"),
        ]
    }
}
