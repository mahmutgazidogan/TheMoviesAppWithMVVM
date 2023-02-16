//
//  CastPeopleTvCreditsDataModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 20.01.2023.
//

import Foundation

//MARK: PeopleTvCredits Model

struct TvCredits: Codable {
    let cast: [PeopleTvCredits]
}

struct PeopleTvCredits: Codable {
    let poster_path: String?
    let original_name: String?
}
