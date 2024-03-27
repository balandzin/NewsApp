//
//  ApiManager.swift
//  NewsApp
//
//  Created by Антон Баландин on 27.03.24.
//

import Foundation

final class ApiManager {
    private static let apiKey = "17962c87cf2c4051a66dfb7f1c82f9bc"
    private static let baseURL = "https://newsapi.org/v2/"
    private static let path = "everything"
    
    static func getNews(completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        let stringUrl = baseURL + path + "?sources=bbc-news&lenguage=en" + "&apiKey=" + apiKey
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
                
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data {
                completion(.success(data))
            }
            
            if let error {
                completion(.failure(error))
            }
        }
        
        session.resume()
    }
    
    private static func handleResponse(
        data: Data?,
        error: Error?,
        completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
            
            if let error {
                completion(.failure(NetworkingError.networkError(error)))
            } else if let data {
                do {
                    let model = try JSONDecoder().decode(NewsRespponseObject.self, from: data)
                    
                    completion(.success(model.articles))
                    
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
                
            } else {
                completion(.failure(NetworkingError.unknown))
            }
            
        }
    
}


