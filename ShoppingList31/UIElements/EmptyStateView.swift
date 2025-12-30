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
        VStack(spacing: 10) {
            Image(viewState.imageResource)
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            
            Text(EmptyStateType.title)
                .font(.mediumTitle)
        
            Text(viewState.subtitle)
                .font(.body)
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
