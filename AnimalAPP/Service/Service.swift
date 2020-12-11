//
//  Service.swift
//  AnimalAPP
//
//  Created by hui liu on 12/8/20.
//

import Foundation

class Service {
    static let shared = Service()

    func fetchAnimal(searchText: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://api.jikan.moe/v3/search/anime?q=\(searchText)"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchFirstTimeData(completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://api.jikan.moe/v3/search/anime?q=naruto"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
