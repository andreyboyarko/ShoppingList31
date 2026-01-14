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
                              Button(role: .destructive) {  } label: {
                                  Label("Delete", systemImage: "trash")
                              }
                              Button {  } label: {
                                  Label("Flag", systemImage: "flag")
                              }
                              .tint(.orange)
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
