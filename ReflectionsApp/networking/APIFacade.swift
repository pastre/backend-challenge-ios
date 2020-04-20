//
//  APIFacade.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
protocol simpleModel: Codable {
    
}
struct UserData: Codable {
    var username: String!
    var password: String!
}

struct User: Codable {
    var username: String!
    var email: String!
    var id: Int
}

struct Reflection: Codable {
    var content: String!
    var createdAt: Date!
    var owner: User!
    var isPublic: Bool!
}



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
    
    func getURL() -> URL {
        return URL(string:
//            "https://ada-backend-challenge.herokuapp.com/api/"
        "http://192.168.100.34:8000/api/"
            + self.rawValue)!
    }
    
}

protocol Response {
    var payload: Data! { get }
}


class APIFacade {
    static let instance = APIFacade()
    
    var session: URLSession!
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    func request(_ endpoint: Endpoint, _ method: HTTPMethod, body: Data? = nil, completion: @escaping (Data?, Error?) -> () ) {
        var request = URLRequest(url: endpoint.getURL())
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        print("Body is", request.httpBody)
        self.session.dataTask(with: request) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                
                completion(nil, error)
                
                return
            }
            
            guard response.statusCode == 200 else {
                completion(nil, APIError.wrongMethod(response.statusCode))
                return
            }
            
            guard let deserialized = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                
                completion(nil, APIError.failedToParseJSON)
                return
                
            }
            
            let isSuccess = (deserialized["status"] as! String) != "error"
            
            if isSuccess {

                
                let payload = try! JSONSerialization.data(withJSONObject: deserialized["payload"], options: [])

                completion(payload, nil)
                return
            }
            
            completion(nil, APIError.runtimeError(deserialized["payload"] as! String ))
            
        }.resume()
        print("Fired!")
        
    }
    
    func authenticate(username: String, password: String, completion: @escaping (User?, Error?) -> () ) {
        let body = try! JSONEncoder().encode([ "username":username, "password":password ])
        
        self.request(.auth, .POST, body: body) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                fatalError("troxa")
            }
            
            completion(user, nil)
            
        }
        
    }
    
    
}
