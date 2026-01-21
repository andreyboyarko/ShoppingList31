//
//  UnitSelectionMenu.swift
//  ShoppingList31
//
//  Created by Владимир on 14.01.2026.
//

import SwiftUI

struct UnitSelectionMenu: View {
    
    @Binding var needShowMenu: Bool
    @Binding var selectedUnit: String
    @Binding var pikerUnitName: UnitsProduct
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(UnitsProduct.allCases) { element in
                UnitMenuCell(menuElement: element,
                             showsSeparator: element != UnitsProduct.allCases.last,
                             isMenuVisible: $needShowMenu,
                             selectedUnit: $selectedUnit,
                             unitSelection: $pikerUnitName
                )
            }
        }
        .frame(width: 220)
        .background(.surfaceBackground)
        .cornerRadius(12)
    }
}

#Preview {
    ZStack {
        Color.appBackground
        UnitSelectionMenu(
            needShowMenu: .constant(true),
            selectedUnit: .constant("шт"),
            pikerUnitName: .constant(.pieces)
        )
    }
}
