//
//  MostPopularMovieViewModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 18.01.2023.
//

import Foundation

protocol MostPopularMovieViewModelProtocol {
    func fetchMovies()
    func setDelegate(output: MostPopularMoviesOutput)
    
    var mostPopularMoviesOutput: MostPopularMoviesOutput? { get }
    var dataList: [MostPopularMovie] { get set }
}

final class MostPopularMovieViewModel: MostPopularMovieViewModelProtocol {
    var mostPopularMoviesOutput: MostPopularMoviesOutput?
    var mostPopularMovieService: MostPopularMovieDatasServiceProtocol
    var dataList: [MostPopularMovie] = []
    
    init() {
        mostPopularMovieService = MostPopularMovieService()
    }
    
    func setDelegate(output: MostPopularMoviesOutput) {
        mostPopularMoviesOutput = output
    }
    
    func fetchMovies() {
        mostPopularMovieService.fetchPopularMovies(url: Constants.mostPopularMovieURL) { [weak self] (model) in
            self?.dataList = model
            self?.mostPopularMoviesOutput?.saveDatas()
        } onFail: { error in
            print(error)
        }
    }
}
