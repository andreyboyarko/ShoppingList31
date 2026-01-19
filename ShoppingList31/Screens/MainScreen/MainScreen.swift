//
//  MainScreen.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/13/26.
//
import SwiftUI

struct MainScreen: View {
    @Environment(ThemeStore.self) var themeStore
    @State var lists: [ListItem]
    
    var body: some View {
        NavigationStack {
            VStack {
                if lists.isEmpty {
                    EmptyStateView(viewState: .createShoppingList)
                        .padding(.top, 88)
                    Spacer()
                } else {
                    mainList
                }
            }
            .background(.appBackground)
            .safeAreaInset(edge: .bottom) {
                ActionButton(title: "Создать список", isActive: true) {
                    print("Pushed button")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text("Мои списки")
                            .font(.screenTitle)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Menu {
                            ForEach(AppTheme.allCases, id: \.self) { theme in
                                themeButton(theme)
                            }
                            
                        } label: {
                            Label("Установить тему", systemImage: "circle.lefthalf.filled.inverse")
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Сортировка по Алфавиту", systemImage: "arrow.up.arrow.down")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 19))
                            .foregroundStyle(.textPrimary)
                            .frame(width: 44, height: 44)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var mainList: some View {
        List {
            ForEach(lists.indices, id: \.self) { index in
                SwipeRow(
                    actions: [
                        SwipeAction(systemImage: "square.and.pencil", tint: .swipeActionIGray) {
                            // редактировать
                        },
                        SwipeAction(systemImage: "plus.square.on.square", tint: .swipeActionIOrange) {
                            // копировать / что нужно
                        },
                        SwipeAction(systemImage: "trash", tint: .swipeActionIRed) {
                            // удалить
                        }
                    ]
                ) {
                    ListCell(listItem: lists[index])
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.appBackground)
                
                if index < lists.count - 1 {
                    Rectangle()
                        .fill(.appBackground)
                        .frame(height: 12)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.appBackground)
                }
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 0)
        .scrollContentBackground(.hidden)
        .background(.appBackground)
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
    
    private func themeButton(_ theme: AppTheme) -> some View {
        Button {
            themeStore.theme = theme
        } label: {
            HStack {
                if themeStore.theme == theme {
                    Image(systemName: "checkmark")
                }
                Text(theme.rawValue)
            }
        }
    }
}

#Preview {
    let store = ThemeStore()
    
    MainScreen(lists: ListItem.mockArray)
        .environment(store)
}

#Preview {
    let store = ThemeStore()
    
    MainScreen(lists: [])
        .environment(store)
}
