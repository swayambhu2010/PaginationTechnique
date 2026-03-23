//
//  Model.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 22/03/26.
//

import Foundation

struct MainData {
    let cursor: Int
    var data: [DataModel]
}

struct DataModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String?
    var age: Int?
    var image: String?
}
