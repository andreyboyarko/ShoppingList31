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
        HStack(spacing: 8) {
            selectedIcon
            nameOfItem
            Spacer()
            countItem
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        separator
            .onAppear {
                shoppingItemStatus = shoppingItem.isSelected
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
            .foregroundStyle(shoppingItemStatus ? .selectedText : .unSelectedText)
    }
    
    private var countItem: some View {
        Text("\(shoppingItem.count) шт.")
            .font(.body)
            .foregroundStyle(shoppingItemStatus ? .selectedText : .unSelectedText)
    }
    
    private var selectedIcon: some View {
        VStack {
            if shoppingItemStatus {
                Image(.checkboxButton)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 22, height: 22)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.checkboxButtonBorder, lineWidth: 2)
                    )
            }
        }
        .frame(width: 44, height: 44)
        .onTapGesture {
            shoppingItemStatus.toggle()
        }
    }
}

#Preview {
    ShoppingCell(shoppingItem: ShoppingItem.mock)
}

#Preview {
    ForEach(ShoppingItem.mockArray, id: \.id) { item in
        ShoppingCell(shoppingItem: item)
    }
}
