//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    
    // MARK: - Properties
    var numberOfCells: Int {
        articles.count
    }
    private var articles: [ArticleResponseObject] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
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
        ApiManager.getNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupMockObjects() {
        articles = [
            ArticleResponseObject.init(title: "First object", description: "First description", urlToImage: "...", date: "27.03.2024"),
            ArticleResponseObject.init(title: "Second object", description: "Second description", urlToImage: "...", date: "27.03.2024"),
            ArticleResponseObject.init(title: "Third object", description: "Third description", urlToImage: "...", date: "27.03.2024"),
            ArticleResponseObject.init(title: "Fourth object", description: "Fourth description", urlToImage: "...", date: "27.03.2024"),
            ArticleResponseObject.init(title: "Fifth object", description: "Fifth description", urlToImage: "...", date: "27.03.2024"),
        ]
    }
}
