//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 8.04.24.
//

import Foundation

final class TechnologyViewModel: NewsListViewModel {
    
    override func loadData() {
        super.loadData()
        
        ApiManager.getNews(from: .technology, page: page) { [weak self] result in
            self?.handleResult(result)
        }
    }
    
    override func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModels)
            self.sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
}
