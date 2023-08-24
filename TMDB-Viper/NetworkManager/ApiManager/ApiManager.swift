//
//  ApiManager.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import Foundation


protocol ApiManagerProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data
}

class ApiManager: ApiManagerProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createUrlRequest())
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        return data
    }
}
