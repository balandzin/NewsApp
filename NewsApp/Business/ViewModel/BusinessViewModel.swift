//
//  BusinessViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 28.03.24.
//

import Foundation

protocol BusinessViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var articles: [TableCollectionViewSection] { get }
    
    func loadData()
}

final class BusinessViewModel: BusinessViewModelProtocol {
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    
    // MARK: - Properties
    private(set) var articles: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    func loadData() {
        ApiManager.getNews(from: .business) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.convertToCellViewModel(articles)
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
        
        for (i, section) in articles.enumerated() {
            for (index, item) in section.items.enumerated() {
                if let article = item as? ArticleCellViewModel, let url = article.imageUrl {
                    ApiManager.getImageData(url: url) { [weak self] result in
                        DispatchQueue.main.async {
                            
                            switch result {
                            case .success(let data):
                                if let article = self?.articles[i].items[index] as? ArticleCellViewModel {
                                    article.imageData = data
                                }
                                self?.reloadCell?(IndexPath(row: index, section: i))
                            case .failure(let error):
                                self?.showError?(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        
        let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
        let secondSection = TableCollectionViewSection(items: viewModels)
        
        self.articles = [firstSection, secondSection]
    }
    
    private func setupMockObjects() {
        articles = [
            TableCollectionViewSection(
                items: [ArticleCellViewModel(
                    article: ArticleResponseObject(
                        title: "First object",
                        description: "First description",
                        urlToImage: "",
                        date: "27.03.2024"
                    )
                )]
            )
        ]
    }
}
