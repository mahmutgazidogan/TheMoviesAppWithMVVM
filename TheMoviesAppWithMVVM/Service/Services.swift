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
    
    static func movieURL() -> String {
        return "\(POPULAR_URL.rawValue)\(API_KEY.rawValue)"
    }
    
    //  Video URL kontrol edilecek https://api.themoviedb.org/3/movie/315162/videos?api_key=5c4396df206a1be40c522966e6fcc2ba
    
    
    static func videoURL(id: Int) -> String {
        return "\(castURL.rawValue)\(id)\(videoPath.rawValue)"
    }
    
    static func castURL(id: Int) -> String {
        return "\(castURL.rawValue)\(id)\(castCreditsPath.rawValue)"
    }
    
}

//MARK: Protocol

protocol MostPopularMovieDatasServiceProtocol {
    func fetchPopularMovies(url: String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchVideoDatas(id: Int, onSuccess: @escaping ([MovieVideos]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchCastDatas(id: Int, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void)
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
    
}
