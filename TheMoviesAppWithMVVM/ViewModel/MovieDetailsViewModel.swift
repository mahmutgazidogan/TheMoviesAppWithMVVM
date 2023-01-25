//
//  MovieDetailsViewModel.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    func fetchVideos(id: Int)
    func fetchCast(id: Int)
    func setDelegate(output: MovieDetailsOutput)
    
    var movieDetailsOutput: MovieDetailsOutput? { get }
    var dataList: MostPopularMovie? { get }
    var videoDetails: [MovieVideos] { get set }
    var castDetails: [CastPersons] { get set }
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    var movieDetailsOutput: MovieDetailsOutput?
    var mostPopularMovieService: MostPopularMovieDatasServiceProtocol = MostPopularMovieService()
    
    var dataList: MostPopularMovie?
    var videoDetails: [MovieVideos] = []
    var castDetails: [CastPersons] = []
    
    init() {
        mostPopularMovieService = MostPopularMovieService()
    }
    
    func setDelegate(output: MovieDetailsOutput) {
        movieDetailsOutput = output
    }
    
    func fetchVideos(id: Int) {
        mostPopularMovieService.fetchVideoDatas(id: id) { [weak self] (model) in
           guard let self = self else { return }
            self.videoDetails = model
            self.movieDetailsOutput?.saveDatas()
        } onFail: { error in
            print(error)
        }
    }
    
    func fetchCast(id: Int) {
        mostPopularMovieService.fetchCastDatas(id: id) { [weak self] (model) in
            guard let self = self else { return }
            self.castDetails = model
            self.movieDetailsOutput?.saveDatas()
        } onFail: { error in
            print(error)
        }
    }

}
