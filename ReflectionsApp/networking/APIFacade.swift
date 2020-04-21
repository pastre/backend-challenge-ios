//
//  APIFacade.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation


class APIFacade {
    static let instance = APIFacade()
    
    var session: URLSession!
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    func request(_ endpoint: Endpoint, _ method: HTTPMethod, body: Data? = nil, completion: @escaping (Data?, Error?) -> () ) {
        self.request(endpoint.getURL(), method, body: body, completion: completion)
    }
    
    func request(_ url: URL, _ method: HTTPMethod, body: Data? = nil, completion: @escaping (Data?, Error?) -> () ) {
        
        var request = URLRequest(url:url)

        request.httpMethod = method.rawValue
        request.httpBody = body
        
        
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
                print("OPS!", String(data: data, encoding: .utf8))
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
    
    
    func validateAndCompleteRequest<T: Codable>(data: Data?, error: Error?, completion: @escaping (T?, Error?) -> ()) {
        
        guard let data = data else {
            completion(nil, error)
            return
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("troxa")
        }
        
        completion(decoded, nil)
    }
    
    // MARK: -  User related methods
    
    func searchUser(_ query: String, completion: @escaping ([User]?, Error?) -> () ) {
        
        var components = URLComponents(string: Endpoint.users.getURLString())!
        
        components.queryItems =  [
            URLQueryItem(name: "username", value: query)
        ]
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        self.request(components.url!, .GET) { (data, error) in
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)
        }

    }
    
    func getAllUsers( completion: @escaping ([User]?, Error?) -> () ) {
        self.request(.users, .GET) { (data, error) in
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)
        }
    }
    
    func createUser(username: String, password: String, email: String, completion: @escaping (User?, Error?) -> () ) {
        
        let body = try! JSONEncoder().encode(
            [
                "username": username,
                "password": password,
                "email":email
            ])
        
        self.request(.users, .POST, body: body) { (data, error) in
            
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)

        }
    }
    
    func authenticate(username: String, password: String, completion: @escaping (User?, Error?) -> () ) {
        let body = try! JSONEncoder().encode([ "username":username,
            "password":password
        ])
        
        self.request(.auth, .POST, body: body) { (data, error) in
            
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)

        }
    }
    
    // MARK: - User reflection methods
    
    func createReflection(content: String, isPublic: Bool = true, completion: @escaping (Reflection?, Error?) -> ()) {
        let body = try! JSONSerialization.data(withJSONObject: [
            "content": content
        ], options: [])
        
        self.request(.reflections, .POST, body: body) { (data, error) in
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)
        }
    }
    
    func deleteReflection(reflectionId: Int, completion: @escaping ([Reflection]?, Error?) -> ()) {
        let url = Endpoint.reflections.getURLString() + "/\(reflectionId)"
        print("URL IS", url)
        self.request(URL(string: url)!, .DELETE) { (data, error) in
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)
        }
    }
    
    
    // MARK: - Public reflection  methods
    func getAllReflections(completion: @escaping ([Reflection]?, Error?) -> () ) {
        
        self.request(.reflections, .GET) { (data, error) in
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)
        }
    }
    

    func getReflectionsInRange(startDate: Date, endDate: Date?, completion: @escaping ([Reflection]?, Error?) -> () ) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "ddMMyyyy"
        
        var params = [
            URLQueryItem(name: "from", value: dateFormatter.string(from: startDate))
        ]
        
        if let endDate = endDate {
            params.append(URLQueryItem(name: "to", value: dateFormatter.string(from: endDate)))
        }
        var components = URLComponents(string: Endpoint.reflections.getURLString())!
        
        components.queryItems = params
      
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        self.request(components.url!, .GET) { (data, error) in
            self.validateAndCompleteRequest(data: data, error: error, completion: completion)
        }
        
    }
}


class TestAPIFacade {
    
    func testSearchUsers() {
        APIFacade.instance.authenticate(username: "asdq", password: "qwe") { (user, error) in
            APIFacade.instance.searchUser("a") { (users, error) in
                print(users, error)
            }
        }
    }
    
    func testGetAllUsers() {
        APIFacade.instance.authenticate(username: "asdq", password: "qwe") { (user, error) in
            APIFacade.instance.getAllUsers { (users, error) in
                print(users, error)
            }
        }
    }
    
    func testGetReflections() {
        APIFacade.instance.authenticate(username: "asdq", password: "qwe") { (user, error) in
            APIFacade.instance.getAllReflections { (reflections, error) in
                print(reflections, error)
            }
        }
    }
    
    func testCreateReflection() {
        
        APIFacade.instance.authenticate(username: "asdq", password: "qwe") { (user, error) in
            APIFacade.instance.createReflection(content: "testeeee") { (reflections, error) in
                print(reflections, error)
            }
        }

    }
    
    func testDeleteReflection() {
         APIFacade.instance.authenticate(username: "asdq", password: "qwe") { (user, error) in
            
            APIFacade.instance.deleteReflection(reflectionId: 1) { (reflections, error) in
                print(reflections, error)
            }
        }
    }
    
    
    func testGetReflectionsInRange() {
        
        APIFacade.instance.authenticate(username: "asdq", password: "qwe") { (user, error) in
            APIFacade.instance.getReflectionsInRange(
                startDate: Date(timeIntervalSince1970: 1586476800),
                endDate: nil)//Date(timeIntervalSince1970: 1586563200))
            { (reflections, error) in
                
                print(reflections, error)
            }
        }
        
    }
}
