//
//  PaginationUseCase.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 22/03/26.
//

import Foundation

protocol PaginationUseCaseProtocol {
    func getAllData() -> MainData
    func getData(index: Int, pageSize: Int) async throws -> [DataModel]
}

class PaginationUseCase: PaginationUseCaseProtocol {
    
    var paginationRepo: PaginationRepoProtocol
    
    init(paginationRepo: PaginationRepoProtocol) {
        self.paginationRepo = paginationRepo
    }
    
    func getAllData() -> MainData {
        paginationRepo.getAllData()
    }
    
    func getData(index: Int, pageSize: Int) async throws -> [DataModel] {
        try await paginationRepo.getData(index: index, pageSize: pageSize)
    }
}
