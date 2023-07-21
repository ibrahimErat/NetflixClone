//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Erat on 8.07.2023.
//

import Foundation

struct Constents {
    static let API_KEY = "5a6543d26dc630330afd0b3669fc7b9d"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDDMAP18WmliIKItZm-DfAar_t6I1Rc3YY"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
    static let headers = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YTY1NDNkMjZkYzYzMDMzMGFmZDBiMzY2OWZjN2I5ZCIsInN1YiI6IjY0YTk3ZDQyYjY4NmI5MDE1MDBmNWJlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AER8CmmIpuhN3ZUKxf7LPg3CPiMdso3EfCS7t8DQnAg"
      ]
}

//API işlemlerinde ortaya çıkabilecek hataları temsil etmek için kullanılabilir.
enum APIError: Error {
    case faildTogetData
}

class APICaller {
    static let shaerd = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constents.baseURL)/3/trending/movie/day?api_key=\(Constents.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                //let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch let error {
                completion(.failure(APIError.faildTogetData))
            }
            
        }
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constents.baseURL)/3/trending/tv/day?api_key=\(Constents.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.faildTogetData))
            }
        }
        task.resume()
    }
    
//    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void ) {
//        
//        guard let url = URL(string: "\(Constents.baseURL)/3/movie/upcoming?api_key=\(Constents.API_KEY)language=en-US&page=1") else {return}
//        
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            do{
//                //let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
//            }catch {
//                print("Veri okunamadı: \(error)")
//               
//            }
//        }
//        task.resume()
//        
//    }
    
    
    // internet sayfasındaki metod
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        

        let request = NSMutableURLRequest(url: NSURL(string: "\(Constents.baseURL)/3/movie/upcoming?language=en-US&page=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constents.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in

            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.faildTogetData))
            }
            
        })

        dataTask.resume() // Bu ifade, HTTP isteğinin gönderilmesini ve yanıtın alınmasını başlatır.
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {


        let request = NSMutableURLRequest(url: NSURL(string: "\(Constents.baseURL)/3/movie/popular?language=en-US&page=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constents.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.faildTogetData))
            }
        })

        dataTask.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        

        let request = NSMutableURLRequest(url: NSURL(string:"\(Constents.baseURL)/3/movie/popular?language=en-US&page=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constents.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.faildTogetData))
            }
        })

        dataTask.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        

        let request = NSMutableURLRequest(url: NSURL(string: "\(Constents.baseURL)/3/discover/movie?api_key=\(Constents.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constents.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.faildTogetData))
            }
        })

        dataTask.resume()
    }
    
    func search(with query: String,completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constents.baseURL)/3/search/movie?query=\(query)&api_key=\(Constents.API_KEY)" )! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constents.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.faildTogetData))
            }
        })

        dataTask.resume()
    }
    
    func getMovie(with query: String,completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constents.YoutubeBaseURL)q=\(query)&key=\(Constents.YoutubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(YoutubeSearchRespose.self, from: data)
                completion(.success(results.items[0]))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
}



