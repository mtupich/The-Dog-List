//
//  dogApiService.swift
//  The_Dog_List
//
//  Created by Maria Tupich on 20/04/22.
//

import Foundation

enum ofErrors: Error {
    case badUrl
    case notNetwork
    case cannotParseJson
}

class DogApiService {
    
    private let baseUrl: String = "https://cachorro-api.herokuapp.com"
    private var statusCode: Int = 0
    
    func requestDataFromApi(callBack: @escaping (Result<[Response], ofErrors>) -> Void) {
        if let url = URL(string: baseUrl) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let jsonResult = try decoder.decode([Response].self, from: data)
                        callBack(.success(jsonResult))
                        if let response = response as? HTTPURLResponse {
                            self.statusCode = response.statusCode
                            print(self.statusCode)
                        }
                    }catch {
                        callBack(.failure(.badUrl)
                        )}
                }
            }.resume()
            
        }
    }
    
}


