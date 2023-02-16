//
//  CastDetailsViewModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 25.01.2023.
//

import Foundation

protocol CastDetailsViewModelProtocol {
    func fetchPersonDetails(id: Int)
    func fetchMovieCredits(id: Int)
    func fetchTvCredits(id: Int)
    func setDelegate(output: CastDetailsOutput)
    
    var castDetailsOutput: CastDetailsOutput? { get }
    var personDetails: CastPeople? { get set }
    var movieCredits: [PeopleMovieCredits] { get set }
    var tvCredits: [PeopleTvCredits] { get set }
}

final class CastDetailsViewModel: CastDetailsViewModelProtocol {
    
    var castDetailsOutput: CastDetailsOutput?
    var mostPopularMovieService: MostPopularMovieDatasServiceProtocol = MostPopularMovieService()
    var personDetails: CastPeople?
    var movieCredits: [PeopleMovieCredits] = []
    var tvCredits: [PeopleTvCredits] = []
    
    init() {
        mostPopularMovieService = MostPopularMovieService()
    }
    
    func setDelegate(output: CastDetailsOutput) {
        castDetailsOutput = output
    }
    
    func fetchPersonDetails(id: Int) {
        mostPopularMovieService.fetchPersonDatas(id: id) { [weak self] (model) in
            self?.personDetails = model
            self?.castDetailsOutput?.saveDatas()
        } onFail: { error in
            print(error)
        }
    }
    
    func fetchMovieCredits(id: Int) {
        mostPopularMovieService.fetchMovieCreditsDatas(id: id) { [weak self] (model) in
            self?.movieCredits = model
            self?.castDetailsOutput?.saveDatas()
        } onFail: { error in
            print(error)
        }
    }
    
    func fetchTvCredits(id: Int) {
        mostPopularMovieService.fetchTvCreditsDatas(id: id) { [weak self] (model) in
            self?.tvCredits = model
            self?.castDetailsOutput?.saveDatas()
        } onFail: { error in
            print(error)
        }
    }
    
}
