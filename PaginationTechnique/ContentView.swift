//
//  ContentView.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 18/03/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel(
        paginationUsecase: PaginationUseCase(paginationRepo: PaginationRepo())
    )
    
    let pageSize = 10
    
    var body: some View {
        NavigationView {
            VStack(spacing: 2) {
                List {
                    ForEach(viewModel.data.indices, id: \.self) { index in
                        let item = viewModel.data[index]
                        
                        VStack(alignment: .leading) {
                            Text(item.name ?? "Unknown")
                                .font(.headline)
                            Text("Age: \(item.age ?? 0)")
                                .font(.subheadline)
                        }
                        .onAppear {
                            viewModel.loadMoreIfNeeded(index: index, pageSize: pageSize)
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
}
