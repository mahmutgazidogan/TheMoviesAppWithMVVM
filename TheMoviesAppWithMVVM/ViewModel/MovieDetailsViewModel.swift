//
//  MovieDetailsViewModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    func fetchCast(id: Int)
    func setDelegate(output: MovieDetailsOutput)
    
    var movieDetailsOutput: MovieDetailsOutput? { get }
    var dataList: MostPopularMovie? { get }
    var castDetails: [CastPersons] { get set }
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    var movieDetailsOutput: MovieDetailsOutput?
    var mostPopularMovieService: MostPopularMovieDatasServiceProtocol = MostPopularMovieService()
    
    var dataList: MostPopularMovie?
    var castDetails: [CastPersons] = []
    
    init() {
        mostPopularMovieService = MostPopularMovieService()
    }
    
    func setDelegate(output: MovieDetailsOutput) {
        movieDetailsOutput = output
    }
    
    func fetchCast(id: Int) {
        mostPopularMovieService.fetchCastDatas(id: id) { [weak self] (model) in
            self?.castDetails = model
            self?.movieDetailsOutput?.saveDatas()
        } onFail: { error in
            print(error)
        }
    }

}
