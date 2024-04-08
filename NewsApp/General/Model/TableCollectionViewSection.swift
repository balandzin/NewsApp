//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Антон Баландин on 8.04.24.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
