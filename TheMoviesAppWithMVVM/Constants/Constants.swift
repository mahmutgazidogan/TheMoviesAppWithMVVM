//
//  Constants.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 18.01.2023.
//

import Foundation

//MARK: Constants

struct Constants {
    
    //MARK: API Constants
    
    static let apiKey = "5c4396df206a1be40c522966e6fcc2ba"
    static let mostPopularMovieURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let castURL = "https://api.themoviedb.org/3/movie/"
    static let castCreditsPath = "/credits?api_key=\(apiKey)"
    static let videoPath = "/videos?api_key=\(apiKey)"
}
