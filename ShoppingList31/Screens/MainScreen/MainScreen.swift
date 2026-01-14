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
            HStack {
                Text("Мои списки")
                    .font(.screenTitle)
                Spacer()
            }
            .frame(height: 52)
            .padding(.leading, 16)
            
            if lists.isEmpty {
                
                EmptyStateView(viewState: .createShoppingList)
                    .padding(.top, 88)
                Spacer()
            } else {
                List(lists) { list in
                    ListCell(listItem: list)
                        .listRowSeparator(.hidden)
                        .listRowInsets(
                            EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                        )
                        .background(.appBackground)
                        .swipeActions(edge: .trailing) {
                            
                            Button(role: .destructive) {
                                // удаление
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.swipeActionIRed)
                            
                            Button {
                                // взаимодействие
                            } label: {
                                Image(systemName: "plus.square.on.square")
                            }
                            .tint(.swipeActionIOrange)
                            
                            Button {
                                // действие для редактирования
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                            .tint(.swipeActionIGray)
                        }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.top, 12)
                
            }
        }
        .background(.appBackground)
        .overlay(alignment: .bottom) {
            ActionButton(title: "Создать список", isActive: true) {
                print("Pushed button")
            }
        }
    }
}

#Preview {
    MainScreen(lists: ListItem.mockArray)
}

#Preview {
    MainScreen(lists: [])
}
