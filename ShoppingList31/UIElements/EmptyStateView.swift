//
//  EmptyStateView.swift
//  ShoppingList31
//
//  Created by Владимир on 28.12.2025.
//

import SwiftUI

struct EmptyStateView: View {
        
    let viewState: EmptyStateType
        
    var body: some View {
        VStack(spacing: 28) {
            Image(viewState.imageResource)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
              
            VStack(spacing: 4) {
                Text(EmptyStateType.title)
                    .font(.smallTitle)
                Text(viewState.subtitle)
                    .font(.body)
            }
        }
        .padding(16)
    }
}

#Preview("addItemToShoppingList") {
    EmptyStateView(viewState: .addItemToShoppingList)
}

#Preview("createShoppingList") {
   EmptyStateView(viewState: .createShoppingList)
}
