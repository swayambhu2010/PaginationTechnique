//
//  AppRouter.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 23/03/26.
//

import Foundation
import SwiftUI
import Combine

class AppRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    private let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    func move(to route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func navigate(to route: Route) -> some View {
        switch route {
        case .listPage:
            makeListView()
        case .detail(_):
            makeDetailView()
        }
    }
    
    func makeListView() -> ContentView {
        let viewModel = ViewModel(
            paginationUsecase: appContainer.paginationUseCase)
        let contentView = ContentView(viewModel: viewModel)
        return contentView
            
    }
    
    func makeDetailView() -> DetailView {
        let detailView = DetailView()
        return detailView
    }
}
