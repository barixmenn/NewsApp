//
//  APICaller.swift
//  News App
//
//  Created by Baris on 6.09.2022.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2022-09-06&sortBy=popularity&apiKey=02592f307fce4acbb3890967aba7aedc")
    }
    
    private init() {}
    
    public func getTopStories (completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
           
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            
            
        }.resume()
        
    }
}
