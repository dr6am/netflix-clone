//
//  ApiCaller.swift
//  Netflix Clone
//
//  Created by Alejandro on 4/26/22.
//

import Foundation

struct Constants {
    static let API_KEY = "d51467f71890cd00c39380ee30acadbc"
    static let baseUrl = "https://api.themoviedb.org/3"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[MovieTitle],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        makeTrendingRequest(url,completionHandler: completion)
    }
    
    func getTrendingTVs(completion: @escaping (Result<[MovieTitle],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        makeTrendingRequest(url,completionHandler: completion)
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[MovieTitle],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        makeTrendingRequest(url,completionHandler: completion)
    }
    
    func getPopular(completion: @escaping (Result<[MovieTitle],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        makeTrendingRequest(url,completionHandler: completion)
        
    }
    func getTopRated(completion: @escaping (Result<[MovieTitle],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        makeTrendingRequest(url,completionHandler: completion)
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[MovieTitle],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        makeTrendingRequest(url,completionHandler: completion)
    }
    
    
    func search(with query: String,completion: @escaping (Result<[MovieTitle],Error>) -> Void){
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let url = URL(string: "\(Constants.baseUrl)/search/movie?api_key=\(Constants.API_KEY)&query=\(query ?? "")") else {
            print("fails at url\n", "\(Constants.baseUrl)/search/movie?api_key=\(Constants.API_KEY)&query=\(query ?? "")")
            return
            
        }
        makeTrendingRequest(url,completionHandler: completion)
    }
    
}
///Request maker
extension APICaller {
    private func makeTrendingRequest(_ url: URL, completionHandler: @escaping (Result<[MovieTitle],Error>) -> Void) -> Void{
        print("request url \(url.absoluteString.split(separator: "?").first ?? "Unknown")")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else {return}
            
            do{
                let results:TrendingResponse = try JSONDecoder().decode(TrendingResponse.self, from: data)
                print("results count for url \(url.absoluteString.split(separator: "?").first ?? "Unknown"): \(results.results.count)")
                completionHandler(.success(results.results))
            }catch {
                    completionHandler(.failure(APIError.failedToGetData))
            }
            
        })
        task.resume()
    }

}
