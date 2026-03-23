//
//  AppContainer.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 23/03/26.
//

import Foundation

class AppContainer {
    
    lazy var paginationRepo: PaginationRepoProtocol = {
        PaginationRepo()
    }()
    
    lazy var paginationUseCase: PaginationUseCaseProtocol = {
        PaginationUseCase(paginationRepo: paginationRepo)
    }()
}
