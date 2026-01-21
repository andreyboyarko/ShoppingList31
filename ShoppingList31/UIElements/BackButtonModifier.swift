//
//  BackButtonModifier.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 20.01.2026.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    let title: String
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: action) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                            Text(title)
                        }
                        .foregroundStyle(.textPrimary)
                        .font(.headline)
                    }
                }
            }
    }
}

extension View {
    func backButtonWith(title: String, action: @escaping () -> Void) -> some View {
        modifier(BackButtonModifier(title: title, action: action))
    }
}

#Preview {
    NavigationStack {
        Text("")
            .backButtonWith(title: "Назад") {
                print("Back tapped")
            }
    }
}
