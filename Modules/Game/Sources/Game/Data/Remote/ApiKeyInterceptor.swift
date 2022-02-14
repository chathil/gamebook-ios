//
//  ApiKeyInterceptor.swift
//  
//
//  Created by Abdul Chathil on 14/02/22.
//

import Alamofire
import Foundation

class ApiKeyInterceptor: RequestInterceptor {
  
  private var apiKey: String {
      guard let filePath = Bundle.module.path(forResource: "RAWG-Info", ofType: "plist") else {
        fatalError("Couldn't find file 'RAWG-Info.plist'. Create a file with this name inside Game directory of this module.")
      }
      
      let plist = NSDictionary(contentsOfFile: filePath)
      guard let value = plist?.object(forKey: "API_KEY") as? String else {
        fatalError("Couldn't find key 'API_KEY' in 'RAWG-Info.plist'. Get an API key from https://rawg.io/apidocs.")
      }
      return value
  }
  
  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    let urlRequest = urlRequest
    let withApiKey = try? URLEncoding.queryString.encode(urlRequest, with: ["key": apiKey])
    completion(.success(withApiKey ?? urlRequest))
  }
}
