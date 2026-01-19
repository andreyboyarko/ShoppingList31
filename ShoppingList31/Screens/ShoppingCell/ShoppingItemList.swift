//
//  ShoppingItemListView.swift
//  ShoppingList31
//
//  Created by Vadzim on 13.01.26.
//

import SwiftUI
import SwiftData

struct ShoppingItemList: View {
    let navigationTitle: String
    @State private var searchText = ""
    @Query private var shoppingItems: [ShoppingItem]
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar
                
                if shoppingItems.isEmpty {
                    EmptyStateView(viewState: .addItemToShoppingList)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(shoppingItems) { item in
                            ShoppingCell(shoppingItem: item)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    deleteButton(for: item)
                                    editButton(for: item)
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
                
                ActionButton(
                    title: ShoppingItemListText.addItemButton,
                    isActive: true,
                    action: addItem
                )
            }
            .background(Color.appBackground)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.textPrimary)
                                    .frame(width: 28, height: 44)
                            }
                            Text(navigationTitle)
                                .font(.headline)
                                .foregroundStyle(.textPrimary)
                            Spacer()
                        }
                
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            sortAlphabetically()
                        } label: {
                            Label(ShoppingItemListText.menuSortAlphabetically, systemImage: "arrow.up.arrow.down")
                        }
                        
                        Button {
                            shareList()
                        } label: {
                            Label(ShoppingItemListText.menuShare, systemImage: "square.and.arrow.up")
                        }
                        Button {
                            uncheckAll()
                        } label: {
                            Label(ShoppingItemListText.menuUncheckAll, systemImage: "arrow.triangle.2.circlepath")
                        }
                        
                        Button(role: .destructive) {
                            deletePurchased()
                        } label: {
                            Label(ShoppingItemListText.menuDeletePurchased, systemImage: "trash")
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
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.textHint)
                .font(.system(size: 17))
            
            ZStack(alignment: .leading) {
                if searchText.isEmpty {
                    Text(ShoppingItemListText.searchPlaceholder)
                        .font(.body)
                        .foregroundStyle(.textHint)
                }
                TextField("", text: $searchText)
                    .font(.body)
                    .foregroundStyle(.textPrimary)
            }
        }
        .padding(8)
        .frame(height: 36)
        .background(Color.searchBarBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 16)
        .frame(height: 58)
    }
    
    private func editButton(for item: ShoppingItem) -> some View {
        Button {
            editItem(item)
        } label: {
            Image(systemName: "square.and.pencil")
                .font(.system(size: 20))
        }
        .tint(.swipeActionIGray)
    }
    
    private func deleteButton(for item: ShoppingItem) -> some View {
        Button(role: .destructive) {
            deleteItem(item)
        } label: {
            Image(systemName: "trash")
                .font(.system(size: 20))
        }
        .tint(.swipeActionIRed)
    }
    
    private func sortAlphabetically() {
        
    }

    
    private func shareList() {
        print("Поделиться")
    }
    
    private func uncheckAll() {
        print("Снять отметки со всех товаров")
    }
    
    private func deletePurchased() {
        print("Удалить купленные товары")
    }
    
    private func editItem(_ item: ShoppingItem) {
        print("Редактировать: \(item.name)")
    }
    
    private func deleteItem(_ item: ShoppingItem) {
        context.delete(item)
    }
    
    private func addItem() {
        print("Добавить товар")
    }
}

enum ShoppingItemListText {
    static let searchPlaceholder = "Поиск"
    static let menuSortAlphabetically = "Сортировать по алфавиту"
    static let menuShare = "Поделиться"
    static let menuUncheckAll = "Снять отметки со всех товаров"
    static let menuDeletePurchased = "Удалить купленные товары"
    static let addItemButton = "Добавить товар"
}

#Preview {
    ShoppingItemList(navigationTitle: "Новый год")
}
