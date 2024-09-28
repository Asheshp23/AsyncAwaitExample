import Foundation

struct Post: Codable, Identifiable, Equatable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}