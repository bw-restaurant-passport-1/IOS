//
//  UserController.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

enum UserType: String {
    case newUser
    case existingUser
}

class UserController {
    
    private let baseURL = URL(string: "https://restaurant-passport1.herokuapp.com/api/users")!
    var id: TokenResponse?
    
    func signup(with user: User, completion: @escaping (Error?) -> Void) {
        let signupURL = baseURL.appendingPathComponent("register")
        
        var request = URLRequest(url: signupURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding sign up object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func login(with user: User, completion: @escaping (Error?) -> Void) {
        let loginURL = baseURL.appendingPathComponent("login")
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.id = try decoder.decode(TokenResponse.self, from: data)
            } catch {
                print("Error decoding token object: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
}
