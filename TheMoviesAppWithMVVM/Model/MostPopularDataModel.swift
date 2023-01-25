//
//  MostPopularDataModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 18.01.2023.
//

import Foundation

// MARK: - Most Popular Movie Model
struct Result: Codable {
    let results: [MostPopularMovie]
}

struct MostPopularMovie: Codable {
    let genre_ids: [Int]?
    let id: Int?
    let original_title, overview: String?
    let poster_path: String?
    let vote_average: Double?
}
