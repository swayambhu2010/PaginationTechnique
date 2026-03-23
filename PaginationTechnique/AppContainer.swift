//
//  AppContainer.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 23/03/26.
//

import Foundation

class AppContainer {
    
    lazy var paginationRepo: PaginationRepo = {
        PaginationRepo()
    }()
}
