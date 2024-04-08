//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

final class GeneralViewModel: NewsListViewModel {
    
    override func loadData() {
        super.loadData()
        
        ApiManager.getNews(from: .general, page: page) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
