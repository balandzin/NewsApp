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
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var reloadCell: ((Int) -> Void)?
    
    // MARK: - Properties
    var numberOfCells: Int {
        articles.count
    }
    private var articles: [ArticleCellViewModel] = [] {
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
        return articles[row]
    }
    
    private func loadData() {
        ApiManager.getNews(from: .general) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articles = self.convertToCellViewModel(articles)
                self.loadImage()

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage() {
        //        guard let url = URL(string: articles[row].imageUrl), let data = try? Data(contentsOf: url) else { return }
        
        for (index, article) in articles.enumerated() {
            guard let url = article.imageUrl else { return }
            ApiManager.getImageData(url: url) { [weak self] result in
                DispatchQueue.main.async {
                    
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articles.map { ArticleCellViewModel(article: $0) }
    }
    
    private func setupMockObjects() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "First object", description: "First description", urlToImage: "", date: "27.03.2024"))
        ]
    }
}
