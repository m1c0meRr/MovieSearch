//
//  Model.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 22.11.2023.
//

import Foundation

struct MovieModel: Codable {
    var keyword: String?
    var pagesCount: Int
    var films: [Movie]
}

struct Movie: Codable {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrl: String
}
