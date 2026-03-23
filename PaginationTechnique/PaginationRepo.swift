//
//  PaginationRepo.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 22/03/26.
//

import Foundation

protocol PaginationRepoProtocol {
    func getAllData() -> MainData
    func getData(index: Int, pageSize: Int) async throws -> [DataModel]
}
    
class PaginationRepo: PaginationRepoProtocol {
    
    var values: [DataModel] = []
    func getAllData() -> MainData {
        MainData(cursor: 0, data: dataArray())
    }
    
    func dataArray() -> [DataModel] {
        for i in 0...100 {
            let value = DataModel(name: "Swayambhu \(i)", age: 35 + i, image: "https://contents.mediadecathlon.com/p3043376/a6d5565fe1ce5db1e0364d03559423f0/p3043376.jpg?format=auto")
            values.append(value)
        }
         return values
    }
    
    func getData(index: Int, pageSize: Int) async throws -> [DataModel] {
        try await Task.sleep(nanoseconds: 1000000000)
        let start = index + 1
        guard start < values.count else { return [] }
        let end = min(start + pageSize, values.count)
        return Array(values[start..<end])
    }
}
