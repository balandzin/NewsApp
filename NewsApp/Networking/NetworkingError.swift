//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

enum NetworkingError: Error {
    case networkError(_ error: Error)
    case unknown
}
