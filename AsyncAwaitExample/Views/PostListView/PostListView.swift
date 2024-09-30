//
//  PostListView.swift
//  AsyncAwaitExample
//
//  Created by Ashesh Patel on 2024-09-28.
//
import SwiftUI

struct PostListView: View {
  @State private var vm: PostListVM
  
  init(vm: PostListVM = PostListVM(networkService: NetworkService())) {
    _vm = State(wrappedValue: vm)
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        List(vm.posts) { post in
          VStack(alignment: .leading) {
            Text(post.title)
              .font(.headline)
            Text(post.body)
              .font(.subheadline)
              .foregroundColor(.secondary)
          }
        }
        .listStyle(PlainListStyle())
        .refreshable {
          vm.fetchPosts()
        }
        .accessibility(identifier: "postList")
      }
      .navigationTitle("Posts")
    }
    .onAppear {
      vm.fetchPosts()
    }
  }
}
