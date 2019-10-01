//
//  Service.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation

enum NetworkError:Error {
    case malformedURL(message:String)
    case errorWith(response:URLResponse?)
    case dataParsinFailed
}

typealias completionHandler<OUT:Decodable> = (Result<OUT , NetworkError>) -> Void
typealias imageDownlaodCompletionHandler = (Data?, NetworkError?) -> Void

protocol  ServiceProtocol {
    associatedtype OUT: Decodable
    func fetchDataFrom(baseUrl:String, path:String, parameters:String, completion:  @escaping completionHandler<OUT>)
    
    func downloadImageFrom(url:String, completion:@escaping imageDownlaodCompletionHandler)
}

class Service<Model:Decodable>:ServiceProtocol, GenericJsonDecoder {
    typealias OUT = Model
    let urlSesson = URLSession(configuration: .default)
    var dataTask:URLSessionDataTask?
    func fetchDataFrom(baseUrl: String, path: String, parameters: String, completion: @escaping (Result<Model, NetworkError>) -> Void) {
        dataTask?.cancel()
        guard var urlComponents = URLComponents(string:baseUrl + path) else {
            completion(.failure(.malformedURL(message:"URL is not correct")))
            return
        }
        urlComponents.query = "\(parameters)"
        guard let url = urlComponents.url else {
            completion(.failure(.malformedURL(message:"URL is nil")))
            return
        }
        dataTask =  urlSesson.dataTask(with:url) { (data, responce, error)  in
            guard let data = data , let _responce = responce as? HTTPURLResponse , _responce.statusCode == 200 else {
                completion(.failure(.errorWith(response: responce)))
                return
            }
            if let tracks =  self.decode(input: data) {
                completion(.success(tracks))
            }else {
                completion(.failure(.dataParsinFailed))
            }
        }
        dataTask?.resume()
    }
    
    func downloadImageFrom(url: String, completion: @escaping imageDownlaodCompletionHandler) {
          let urlSesson = URLSession(configuration: .default)
          guard let urlComponents = URLComponents(string:url) else {
              completion(nil, .malformedURL(message:"URL is not correct"))
              return
          }
          guard let url = urlComponents.url else {
              completion(nil, .malformedURL(message:"URL is nil"))
              return
          }
          dataTask =  urlSesson.dataTask(with:url) { (data, responce, error)  in
              guard let data = data , let _responce = responce as? HTTPURLResponse , _responce.statusCode == 200 else {
                  completion(nil, .errorWith(response:responce))
                  return
              }
            completion(data, nil)

          }
          dataTask?.resume()
      }
}



