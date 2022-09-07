//
//  News.swift
//  News App
//
//  Created by Baris on 6.09.2022.
//

import Foundation

//MARK: - News Model
struct News: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source : Source
    let title: String
    let description: String
    let url: String?
    let urlToImage : String?
    let publishedAt: String?
 
}

struct Source: Codable {
    let name : String
}
