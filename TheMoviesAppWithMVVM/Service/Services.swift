//
//  Services.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 18.01.2023.
//

import Foundation
import Alamofire

enum MostPopularMovieAPIs: String {
    case API_KEY = "5c4396df206a1be40c522966e6fcc2ba"
    case POPULAR_URL = "https://api.themoviedb.org/3/movie/popular?api_key="
    case castURL = "https://api.themoviedb.org/3/movie/"
    case videoPath = "/videos?api_key=5c4396df206a1be40c522966e6fcc2ba"
    case castCreditsPath = "/credits?api_key=5c4396df206a1be40c522966e6fcc2ba"
    case personURL = "https://api.themoviedb.org/3/person/"
    case personDetailsPath = "?api_key=5c4396df206a1be40c522966e6fcc2ba"
    case movieCreditsPath = "/movie_credits?api_key=5c4396df206a1be40c522966e6fcc2ba"
    case tvCreditsPath = "/tv_credits?api_key=5c4396df206a1be40c522966e6fcc2ba"
    
    static func movieURL() -> String {
        return "\(POPULAR_URL.rawValue)\(API_KEY.rawValue)"
    }
    
    static func videoURL(id: Int) -> String {
        return "\(castURL.rawValue)\(id)\(videoPath.rawValue)"
    }
    
    static func castURL(id: Int) -> String {
        return "\(castURL.rawValue)\(id)\(castCreditsPath.rawValue)"
    }
    
    static func personURL(id: Int) -> String {
        return "\(personURL.rawValue)\(id)\(personDetailsPath.rawValue)"
    }
    
    static func movieCreditsURL(id: Int) -> String {
        return "\(personURL.rawValue)\(id)\(movieCreditsPath.rawValue)"
    }
    
    static func tvCreditsURL(id: Int) -> String {
        return "\(personURL.rawValue)\(id)\(tvCreditsPath.rawValue)"
    }
    
}

//MARK: Protocol

protocol MostPopularMovieDatasServiceProtocol {
    func fetchPopularMovies(url: String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchVideoDatas(id: Int, onSuccess: @escaping ([MovieVideos]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchCastDatas(id: Int, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchPersonDatas(id: Int, onSuccess: @escaping (CastPeople) -> Void, onFail: @escaping (String?) -> Void)
    func fetchMovieCreditsDatas(id: Int, onSuccess: @escaping ([PeopleMovieCredits]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchTvCreditsDatas(id: Int, onSuccess: @escaping ([PeopleTvCredits]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Fetch Datas

struct MostPopularMovieService: MostPopularMovieDatasServiceProtocol {
        
    func fetchPopularMovies(url: String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(MostPopularMovieAPIs.movieURL(), method: .get).responseDecodable(of: Result.self) { (response) in
            guard let datas = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(datas.results)
        }
    }
    
    func fetchVideoDatas(id: Int, onSuccess: @escaping ([MovieVideos]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(MostPopularMovieAPIs.videoURL(id: id), method: .get).responseDecodable(of: Videos.self) { (response) in
            guard let datas = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(datas.results)
        }
    }
    
    func fetchCastDatas(id: Int, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(MostPopularMovieAPIs.castURL(id: id), method: .get).responseDecodable(of: Cast.self) { (response) in
            guard let datas = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(datas.cast)
        }
    }
    
    func fetchPersonDatas(id: Int, onSuccess: @escaping (CastPeople) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(MostPopularMovieAPIs.personURL(id: id), method: .get).responseDecodable(of: CastPeople.self) { (response) in
            guard let datas = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(datas)
        }
    }
    
    func fetchMovieCreditsDatas(id: Int, onSuccess: @escaping ([PeopleMovieCredits]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(MostPopularMovieAPIs.movieCreditsURL(id: id), method: .get).responseDecodable(of: MovieCredits.self) { (response) in
            guard let datas = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(datas.cast)
        }
    }
    
    func fetchTvCreditsDatas(id: Int, onSuccess: @escaping ([PeopleTvCredits]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(MostPopularMovieAPIs.tvCreditsURL(id: id), method: .get).responseDecodable(of: TvCredits.self) { (response) in
            guard let datas = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(datas.cast)
        }
    }
    
}
