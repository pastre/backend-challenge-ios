//
//  Enums.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

enum APIError: Error {
    case failedToParseJSON
    case wrongMethod(Int)
    case runtimeError(String)
}

enum HTTPMethod: String {
    case GET
    case POST
}
enum Endpoint: String {
    
    case reflections
    case auth
    case users
    
    func getURL() -> URL {
        return URL(string:
//            "https://ada-backend-challenge.herokuapp.com/api/"
        "http://192.168.100.34:8000/api/"
            + self.rawValue)!
    }
    
}
