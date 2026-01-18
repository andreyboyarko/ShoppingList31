//
//  MainScreen.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/13/26.
//
import SwiftUI

struct MainScreen: View {
    @State var lists: [ListItem]
    
    var body: some View {
        VStack {
            screenTitle
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
    }
    
    private var screenTitle: some View {
        HStack {
            Text("Мои списки")
                .font(.screenTitle)
            Spacer()
            MainScreenMenu(sortAlphabetically: {
                
            })
        }
        .frame(height: 52)
        .padding(.horizontal, 16)
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
