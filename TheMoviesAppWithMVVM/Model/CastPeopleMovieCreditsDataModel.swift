//
//  CastPeopleMovieCreditsDataModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 20.01.2023.
//

import Foundation

//MARK: PeopleMovieCredits Model

struct PeopleMovieCredits: Codable {
    let poster_path: String?
}
struct MovieCredits: Codable {
    let cast: [PeopleMovieCredits]
}
