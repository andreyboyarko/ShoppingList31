//
//  Router.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 19.01.2026.
//

import SwiftUI

enum Screen: Hashable {
    case lists
    case createList
    case editList(ListItem.ID)
    case items(ListItem.ID)
}

@Observable
class Router {
    var path = NavigationPath()
    let root: Screen = .lists
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

struct RouterViewModifier: ViewModifier {
    @State private var router = Router()
    
    private func routeScreen(for screen: Screen) -> some View {
        Group {
            switch screen {
            case .lists: MainScreen()
            case .createList: ListEditorView(mode: .create)
            case .editList(let id): ListEditorView(mode: .edit(id: id))
            case .items(let id): ShoppingItemList(listId: id)
            }
        }
        .environment(router)
    }
    
    func body(content: Content) -> some View {
        Group {
            NavigationStack(path: $router.path) {
                routeScreen(for: .lists)
                    .navigationDestination(for: Screen.self) { screen in
                        routeScreen(for: screen)
                            .appBackground()
                    }
            }
        }
    }
}

extension View {
    func withRouter() -> some View {
        modifier(RouterViewModifier())
    }
}
