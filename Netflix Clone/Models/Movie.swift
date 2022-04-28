//
//  Movie.swift
//  Netflix Clone
//
//  Created by Alejandro on 4/26/22.
//

import Foundation



struct TrendingResponse: Codable {
    let results: [MovieTitle]
}

struct MovieTitle: Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let poster_path: String
    let overview: String?
    let vote_count: Int?
    let vote_average: Float?
    let release_date: String?
}

