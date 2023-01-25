//
//  CastDataModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 20.01.2023.
//

import Foundation

//MARK: CastPersons Model

struct Cast: Codable {
    let cast: [CastPersons]
}

struct CastPersons: Codable {
    let name: String?
    let profile_path: String?
    let id: Int?
    let known_for_department: String?
}


