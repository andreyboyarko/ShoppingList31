//
//  ShoppingCell.swift
//  ShoppingList31
//
//  Created by Владимир on 02.01.2026.
//

import SwiftUI

struct ShoppingCell: View {
    let list: ListItem
    let shoppingItem: ShoppingItem
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                selectedIcon
                nameOfItem
                Spacer()
                countItem
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            separator
        }
        .background(Color.appBackground)
        .onChange(of: shoppingItem.isPurchased, { _, newValue in
            if newValue == true {
                list.completed += 1
            } else {
                list.completed -= 1
            }
        })
    }
    
    private var separator: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 1)
            .foregroundColor(.shoppingSeparator)
    }
    
    private var nameOfItem: some View {
        Text(shoppingItem.name)
            .font(.body)
            .foregroundStyle(shoppingItem.isPurchased ? .textGrayList : .textSecondary)
    }
    
    private var countItem: some View {
        Text("\(shoppingItem.count) \(shoppingItem.unit).")
            .font(.body)
            .foregroundStyle(shoppingItem.isPurchased ? .textGrayList : .textSecondary)
    }
    
    private var selectedIcon: some View {
        Image(systemName: shoppingItem.isPurchased ? "checkmark.square.fill" : "square")
            .resizable()
            .frame(width: 22, height: 22)
            .foregroundStyle(
                shoppingItem.isPurchased
                ? .turquoise
                : .textGrayList
            )
            .frame(width: 44, height: 44)
            .contentShape(Rectangle())
            .onTapGesture {
                shoppingItem.isPurchased.toggle()
            }
    }
}

#Preview {
    let list = ListItem(
        color: IconColor.green,
        icon: Icon.paw,
        title: "Кошке",
        completed: 1,
        total: 4
    )
    
    let mock = ShoppingItem(
        name: "Молоко",
        count: 2,
        unit: "л",
        isSelected: true,
        list: list
    )
    
    ShoppingCell(list: list, shoppingItem: mock)
}

#Preview {
    let list = ListItem(
        color: IconColor.green,
        icon: Icon.paw,
        title: "Кошке",
        completed: 1,
        total: 4
    )
    let mockArray = [
        ShoppingItem(name: "Хлеб", count: 1, unit: "шт", isSelected: false, list: list),
        ShoppingItem(name: "Яйца", count: 10, unit: "шт", isSelected: true, list: list),
        ShoppingItem(name: "Сыр", count: 1, unit: "кг", isSelected: false, list: list),
        ShoppingItem(name: "Кофе", count: 1, unit: "кг", isSelected: true, list: list),
        ShoppingItem(name: "Фрукты", count: 5, unit: "кг", isSelected: false, list: list)
    ]
    
    ForEach(mockArray, id: \.id) { item in
        ShoppingCell(list: list, shoppingItem: item)
    }
}
