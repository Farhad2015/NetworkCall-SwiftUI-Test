//
//  LoginController.swift
//  NetworkCall Test
//
//  Created by Artificial-Soft Air on 4/7/21.
//

import Foundation

class LoginApi{
    enum NetworkError: Error{
        case requestFailed, unknown
    }
//    func callLoginApi(_ username: String,_ password: String, completion: @escaping (loginData, String) -> ()){
    func callLoginApi(_ username: String,_ password: String, completion: @escaping (Result<loginData, NetworkError>) -> Void){
        guard let url =  URL(string:"https://abcd.com/api/login.php")
        else{
            return
        }
        
        let body = "user_name=\(username)&password=\(password)"
        let finalBody = body.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print("hello error: \(error)")
                return
            }
            
            guard let data = data else{
                return
            }
            
            
            do {
                let finalData = try JSONDecoder().decode(loginData.self,from: data)
                DispatchQueue.main.async {
//                    completion(finalData, "0")
                    completion(.success(finalData))
                }
            } catch DecodingError.dataCorrupted(let context){
                print(context.debugDescription)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not Found")
                print("Debug Description:", context.debugDescription)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not Found")
                print("Debug Description:", context.debugDescription)
            } catch DecodingError.typeMismatch(let type, let context)  {
                print("Type '\(type)' mismatch")
                print("Debug Description:", context.debugDescription)
                
                completion(.failure(.requestFailed))
                
            } catch {
                print("error: ", error)
                completion(.failure(.unknown))
            }
            
        }.resume()
    }
}
