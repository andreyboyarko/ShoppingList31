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
                List {
                    ForEach(lists.indices, id: \.self) { index in

                        SwipeRow(
                            height: 84,
                            cornerRadius: 16,
                            buttonWidth: 62,
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
                                .clipShape(RoundedCorners(radius: 16, corners: [.topLeft, .bottomLeft]))
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

                        if index < lists.count - 1 {
                            Rectangle()
                                .fill(.appBackground)
                                .frame(height: 12)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
