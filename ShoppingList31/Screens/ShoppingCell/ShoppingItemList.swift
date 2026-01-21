//
//  ShoppingItemListView.swift
//  ShoppingList31
//
//  Created by Vadzim on 13.01.26.
//

import SwiftUI
import SwiftData

struct ShoppingItemList: View {
    let listId: UUID
    
    var navigationTitle: String {
        shoppingLists.first?.title ?? ""
    }
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(Router.self) private var router
    
    @State private var searchText = ""
    @State private var formConfig: FormConfig?
    @State private var isAlphabeticalSortEnabled = false
    @State private var isSharePresented = false
    
    @Query private var shoppingItems: [ShoppingItem]
    @Query private var shoppingLists: [ListItem]
    
    private var visibleItems: [ShoppingItem] {
        let filtered = searchText.isEmpty
        ? shoppingItems
        : shoppingItems.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
        
        if isAlphabeticalSortEnabled {
            return filtered.sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        } else {
            return filtered
        }
    }
    
    init(listId: UUID) {
        self.listId = listId
        _shoppingLists = Query(filter: #Predicate<ListItem> { $0.id == listId })
        _shoppingItems = Query(
            filter: #Predicate<ShoppingItem> { $0.list?.id == listId },
            sort: \ShoppingItem.createdAt, order: .reverse
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            
            if shoppingItems.isEmpty {
                EmptyStateView(viewState: .addItemToShoppingList)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(visibleItems) { item in
                        if let list = shoppingLists.first {
                            ShoppingCell(list: list, shoppingItem: item)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    deleteButton(for: item)
                                    editButton(for: item)
                                }
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
        .backButtonWith(title: navigationTitle) {
            router.pop()
        }
        .sheet(item: $formConfig) { config in
            ProductFormView(config: config)
        }
        .sheet(isPresented: $isSharePresented) {
            ShareLink(
                item: shoppingItems.shareText,
                subject: Text("Список покупок")
            ) {
                Label("Поделиться", systemImage: "square.and.arrow.up")
                    .font(.headline)
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        sortAlphabetically()
                    } label: {
                        Label(ShoppingItemListText.menuSortAlphabetically, systemImage: "arrow.up.arrow.down")
                    }
                    
                    ShareLink(
                        item: shoppingItems.shareText,
                        preview: SharePreview("Список покупок: \(shoppingLists.first?.title ?? "-")")
                    ) {
                        Label(
                            ShoppingItemListText.menuShare,
                            systemImage: "square.and.arrow.up"
                        )
                    }
                    .disabled(shoppingItems.isEmpty)
                    
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
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.textPrimary)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
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
        isAlphabeticalSortEnabled.toggle()
    }
    
    private func uncheckAll() {
        shoppingItems.forEach { item in
            if item.isPurchased {
                item.isPurchased = false
            }
        }
    }
    
    private func deletePurchased() {
        guard let list = shoppingLists.first else { return }
        
        shoppingItems.forEach { item in
            if item.isPurchased {
                context.delete(item)
                list.completed -= 1
                list.total -= 1
            }
        }
    }
    
    private func editItem(_ item: ShoppingItem) {
        formConfig = FormConfig(product: item)
    }
    
    private func deleteItem(_ item: ShoppingItem) {
        context.delete(item)
        
        guard let list = shoppingLists.first else { return }
        
        list.total -= 1
        if item.isPurchased {
            list.completed -= 1
        }
    }
    
    private func addItem() {
        guard let list = shoppingLists.first else { return }
        formConfig = FormConfig(list: list)
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
    NavigationStack {
        ShoppingItemList(listId: UUID())
    }
    .environment(Router())
}
