//
//  PostListVM.swift
//  AsyncAwaitExample
//
//  Created by Ashesh Patel on 2024-09-28.
//
import Foundation

@Observable
class PostListVM {
  var posts: [Post] = []
  @ObservationIgnored var networkService: NetworkServiceProtocol
  
  init(posts: [Post] = [], networkService: NetworkService) {
    self.posts = posts
    self.networkService = networkService
  }
  
  func fetchPosts() {
    Task {
      do {
        let data = try await networkService.getData()
        switch data {
        case .success(let data):
          let decoder = JSONDecoder()
          if let data = data {
            Task { @MainActor in
              posts = try decoder.decode([Post].self, from: data)
            }
          }
        case .failure:
          break
        }
     
      } catch {
        print("Error: \(error.localizedDescription)")
      }
    }
  }
  
}
