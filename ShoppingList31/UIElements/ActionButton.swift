//
//  ActionButton.swift
//  ShoppingList31
//
//  Created by Stepan Chuiko on 03.01.2026.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.navigationBarButton)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .foregroundStyle(textColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .disabled(!isActive)
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }

    private var backgroundColor: Color {
        isActive ? .turquoise : .grayButton
    }

    private var textColor: Color {
        isActive ? .white : .gray
    }
}

#Preview("Active") {
    Spacer()

    ActionButton(title: "Создать список", isActive: true) {
        print("Pushed button")
    }
}

#Preview("Inactive") {
    Spacer()

    ActionButton(title: "Создать список", isActive: false) {
        print("Pushed button")
    }
}
