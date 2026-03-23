//
//  PaginationTechniqueApp.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 18/03/26.
//

import SwiftUI

@main
struct PaginationTechniqueApp: App {
    
    @StateObject var router: AppRouter = AppRouter(appContainer: AppContainer())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                router.navigate(to: .listPage)
                    .navigationDestination(for: Route.self) { route in
                        router.navigate(to: route)
                    }
            }
            .environmentObject(router)
        }
    }
}
