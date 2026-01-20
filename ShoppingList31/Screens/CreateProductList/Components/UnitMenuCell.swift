//
//  UnitMenuCell.swift
//  ShoppingList31
//
//  Created by Владимир on 14.01.2026.
//

import SwiftUI

struct UnitMenuCell: View {
    
    let menuElement: UnitsProduct
    let showsSeparator: Bool
    
    @Binding var isMenuVisible: Bool
    @Binding var selectedUnit: String
    @Binding var unitSelection: UnitsProduct
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                checkmarkImage
                selectedUnitName
                Spacer()
            }
            .padding(.leading, 7)
            .padding(.vertical, 11)
            
            if showsSeparator {
                Divider()
                    .background(Color.shoppingSeparator)
                    .padding(.horizontal, 0)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectUnit()
        }
    }
    
    private var checkmarkImage: some View {
        Image(systemName: "checkmark")
            .bold()
            .frame(width: 24)
            .foregroundColor(menuElement.rawValue == selectedUnit ? .textPrimary : .clear)
    }
    
    private var selectedUnitName: some View {
        Text(menuElement.localizedName)
            .font(.body)
            .foregroundColor(.textPrimary)
    }
    
    private func selectUnit() {
        selectedUnit = menuElement.rawValue
        unitSelection = menuElement
        isMenuVisible = false
    }
}

#Preview {
    ZStack {
        Color.appBackground
        VStack(spacing: 0) {
            UnitMenuCell(
                menuElement: .pieces,
                showsSeparator: true,
                isMenuVisible: .constant(true),
                selectedUnit: .constant("шт"),
                unitSelection: .constant(.pieces)
            )
            .frame(width: 220, height: 50)
            .background(Color.white)

            UnitMenuCell(
                menuElement: .kilogram,
                showsSeparator: false,
                isMenuVisible: .constant(true),
                selectedUnit: .constant("шт"),
                unitSelection: .constant(.pieces)
            )
            .frame(width: 220)
            .background(Color.white)
        }
    }
}
