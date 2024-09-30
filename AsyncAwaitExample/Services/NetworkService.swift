//
//  NetworkService.swift
//  AsyncAwaitExample
//
//  Created by Ashesh Patel on 2024-09-28.
//

import Foundation

protocol NetworkServiceProtocol {
  func getData() async throws -> (Result<Data?, Error>)
}

class NetworkService: NetworkServiceProtocol {
  func getData() async throws -> (Result<Data?, Error>) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
      return .failure(NetworkError.invalidURL)
    }
    let request = URLRequest(url: url)
    let (data, response) = try await URLSession.shared.data(for: request)
      
   if let httpResponse = response as? HTTPURLResponse {
      switch httpResponse.statusCode {
      case 200..<300:
        return .success(data)
      default:
        return .failure(NetworkError.invalidResponse)
      }
    } else {
      return .failure(NetworkError.invalidResponse)
    }
  }
}

enum NetworkError: Error {
  case invalidResponse
  case invalidURL
}
