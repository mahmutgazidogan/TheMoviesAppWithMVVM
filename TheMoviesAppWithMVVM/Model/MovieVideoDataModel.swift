//
//  MovieVideoDataModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 20.01.2023.
//

import Foundation

//MARK: MovieVideos Model

struct Videos: Codable {
    let results: [MovieVideos]
}

struct MovieVideos: Codable {
    let key: String?
    let name: String?
}


