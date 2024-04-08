//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

final class GeneralViewModel: NewsListViewModel {
    
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getNews(from: .general, page: page, searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
