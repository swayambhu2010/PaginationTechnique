//
//  ContentView.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 18/03/26.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var router: AppRouter
    
    let pageSize = 10
    
    var body: some View {
            VStack(spacing: 2) {
                List {
                    ForEach(viewModel.data.indices, id: \.self) { index in
                        let item = viewModel.data[index]
                        HStack {
                            CachedAsyncImage(urlString: item.image)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(item.name ?? "Unknown")
                                    .font(.headline)
                                Text("Age: \(item.age ?? 0)")
                                    .font(.subheadline)
                            }
                        }
                        .onAppear {
                            viewModel.loadMoreIfNeeded(index: index, pageSize: pageSize)
                        }
                        .onTapGesture {
                            router.move(to: .detail(item))
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Pagination Demo")
            .onAppear {
                if viewModel.data.isEmpty {
                    viewModel.fetchNext(pageSize: pageSize)
                }
            }
            .refreshable {
                viewModel.reset()
                viewModel.fetchNext(pageSize: pageSize)
            }
    }
}
