//
//  NetworkManager.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 16.10.2023.
//

import Foundation
import UIKit

final class ServiceManager {
    
    static let shared = ServiceManager()
    private init() {}
    
    public func searchKeywordFilm(with text: String, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        guard let decodeText = text.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Ошибка декодирования строки")
            return
        }
        
        guard let url = URL(string: URLString.ServerURL.keyURL.rawValue + "\(decodeText)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(APIKEY.apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MovieModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getTopFilms(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        
        guard let url = URL(string: URLString.ServerURL.topAwaitURL.rawValue) else {
            print("Invalid topAwaitURL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(APIKEY.apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MovieModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func requestImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        task.resume()
    }
}
