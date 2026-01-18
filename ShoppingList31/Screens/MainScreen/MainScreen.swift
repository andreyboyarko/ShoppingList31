//
//  MainScreen.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/13/26.
//
import SwiftUI
import SwiftData

struct MainScreen: View {
    @Environment(\.modelContext) private var context
    @Query private var lists: [ListItem]
    
    var body: some View {
        NavigationStack {
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
                    
                }
            }
        }
    }
    
    private var screenTitle: some View {
        HStack {
            Text("Мои списки")
                .font(.screenTitle)
            Spacer()
        }
        .frame(height: 52)
        .padding(.leading, 16)
    }
    
    private var mainList: some View {
        List {
            ForEach(lists) { list in
                SwipeRow(
                    actions: [
                        SwipeAction(systemImage: "square.and.pencil", tint: .swipeActionIGray) {
                            // навигация в редактировать
                        },
                        SwipeAction(systemImage: "plus.square.on.square", tint: .swipeActionIOrange) {
                            // копировать / что нужно
                        },
                        SwipeAction(systemImage: "trash", tint: .swipeActionIRed) {
                            context.delete(list)
                        }
                    ]
                ) {
                    ListCell(listItem: list)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.appBackground)
                
                if (lists.firstIndex(of: list) ?? 0) + 1 < lists.count {
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
    MainScreen()
}
