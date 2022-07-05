//
//  WebServiceHandler.swift
//  LloydsCodeTest
//
//  Created by Darshan Gajera on 04/07/2022.
//


import Foundation

enum API : String {
    static let BaseURL = "https://code.mil/"
    case code = "code.json"
    
    var url : URL {
        get{
            return URL(string: API.BaseURL + self.rawValue)! 
        }
    }
}

enum APIError: Error {
    case error(Error)
    case noData
    case invalidResponseCode(Int)
}

protocol WebServiceHandlerProtocol {
    func getWebService(wsMethod: URL, complete:@escaping (Result<Data, APIError>) -> Void)
}

class WebServiceHandler: WebServiceHandlerProtocol {
    static let shared = WebServiceHandler()
    
    func getWebService(wsMethod: URL, complete:@escaping (Result<Data, APIError>) -> Void) {
    
        let session = URLSession.shared
        let request = URLRequest(url: wsMethod)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if let error = error {
                complete(.failure(.error(error)))
            }
            
            guard let data = data else {
                complete(.failure(.noData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    complete(.success(data))
                default:
                    print("Err Status Code: \(response.statusCode)")
                    complete(.failure(.invalidResponseCode(response.statusCode)))
                }
            }
        })
        task.resume()
    }
}

