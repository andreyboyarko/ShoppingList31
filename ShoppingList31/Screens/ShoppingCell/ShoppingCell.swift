//
//  ShoppingCell.swift
//  ShoppingList31
//
//  Created by Владимир on 02.01.2026.
//

import SwiftUI

struct ShoppingCell: View {
    let shoppingItem: ShoppingItem
    @State var shoppingItemStatus: Bool = false
    
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
        .onAppear {
            shoppingItemStatus = shoppingItem.isPurchased
        }
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
            .foregroundStyle(shoppingItemStatus ? .textGrayList : .textSecondary)
    }
    
    private var countItem: some View {
        Text("\(shoppingItem.count) \(shoppingItem.unit).")
            .font(.body)
            .foregroundStyle(shoppingItemStatus ? .textGrayList : .textSecondary)
    }
    
    private var selectedIcon: some View {
            Image(systemName: shoppingItemStatus ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundStyle(
                    shoppingItemStatus
                    ? .turquoise
                    : .textGrayList
                )
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
                .onTapGesture {
                    shoppingItemStatus.toggle()
                }
        }
}

#Preview {
    let mock = ShoppingItem(
        name: "Молоко",
        count: 2,
        unit: "л",
        isSelected: true
    )
    
    ShoppingCell(shoppingItem: mock)
}

#Preview {
    let mockArray = [
        ShoppingItem(name: "Хлеб", count: 1, unit: "шт", isSelected: false),
        ShoppingItem(name: "Яйца", count: 10, unit: "шт", isSelected: true),
        ShoppingItem(name: "Сыр", count: 1, unit: "кг", isSelected: false),
        ShoppingItem(name: "Кофе", count: 1, unit: "кг", isSelected: true),
        ShoppingItem(name: "Фрукты", count: 5, unit: "кг", isSelected: false)
    ]
    
    ForEach(mockArray, id: \.id) { item in
        ShoppingCell(shoppingItem: item)
    }
}
