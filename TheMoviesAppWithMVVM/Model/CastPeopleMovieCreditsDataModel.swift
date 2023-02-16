//
//  CastPeopleMovieCreditsDataModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 20.01.2023.
//

import Foundation

//MARK: PeopleMovieCredits Model

struct MovieCredits: Codable {
    let cast: [PeopleMovieCredits]
}

struct PeopleMovieCredits: Codable {
    let poster_path: String?
    let original_title: String?
}

