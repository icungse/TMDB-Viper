//
//  RequestManagerProtocol.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    let apiManager: ApiManagerProtocol
    let parser: DataParserProtocol
    
    init(
        apiManager: ApiManagerProtocol = ApiManager(),
        parser: DataParserProtocol = DataParser()
    ) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.perform(request)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}
