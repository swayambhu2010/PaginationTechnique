//
//  ViewModel.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 18/03/26.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var hasMore: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMsg: String = ""
    @Published var data: [DataModel] = []
    
    var allData: [DataModel] = []
    let paginationUsecase: PaginationUseCaseProtocol
    var currentIndex = 0
    
    init(paginationUsecase: PaginationUseCaseProtocol) {
        self.paginationUsecase = paginationUsecase
        self.getAllData()
    }
    
    func getAllData() {
        allData = paginationUsecase.getAllData().data
    }
    
    func loadMoreIfNeeded(index: Int, pageSize: Int) {
        guard !isLoading && hasMore else { return }
        
        let thresholdIndex = max(data.count - 3, 0)
        
        if index == thresholdIndex {
            fetchNext(pageSize: pageSize)
        }
    }
    
    // Initial load
    func fetchNext(pageSize: Int) {
        guard !isLoading && hasMore else { return }
        
        isLoading = true
        
        Task {
            do {
                let newData = try await paginationUsecase.getData(
                    index: currentIndex,
                    pageSize: pageSize
                )
                
                // Append (important)
                data.append(contentsOf: newData)
                
                // Update cursor
                currentIndex += newData.count
                
                // Check if more data exists
                hasMore = newData.count == pageSize
                
            } catch {
                errorMsg = "Problem in Fetching"
            }
            
            isLoading = false
        }
    }
    
    func reset() {
        currentIndex = 0      // reset cursor
        data.removeAll()       // clear UI data
        hasMore = true         // allow pagination again
        isLoading = false      // stop any loading state
        errorMsg = ""          // clear errors
    }
}
