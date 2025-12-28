//
//  EmptyStateView.swift
//  ShoppingList31
//
//  Created by Владимир on 28.12.2025.
//

import SwiftUI

struct EmptyStateView: View {
    
    // MARK: - Property
    
    let viewState: EmptyStateType
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 10) {
            Image(viewState.imageName)
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            
            Text(EmptyStateType.title)
                .font(.mediumTitle.bold())
            
            Text(viewState.subtitle)
                .font(.body)
        }
        .padding(16)
    }
}

#Preview {
    EmptyStateView(viewState: .addItemToShoppingList)
   //EmptyStateView(viewState: .createShoppingList)
}
