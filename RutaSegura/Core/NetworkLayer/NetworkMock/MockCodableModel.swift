//
//  MockCodableModel.swift
//  NetworkLayer
//
//  Created by Irving Delgado Silva on 17/01/22.
//

import Foundation

struct MockCodableModel: Codable {
    let page: Int
    let results: [ResultModel]
    let total_pages: Int
    let total_results: Int
}

struct ResultModel: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let poster_path: String
    let vote_count: Int
    let video: Bool
    let vote_average: Float
    let title: String
    let overview: String
    let release_date: String
    let popularity: Float
    let media_type: String
}
