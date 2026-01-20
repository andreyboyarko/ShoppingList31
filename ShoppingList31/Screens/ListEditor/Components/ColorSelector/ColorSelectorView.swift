//
//  ColorSelectorView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 28.12.2025.
//

import SwiftUI

struct ColorSelectorView: View {
    
    @Binding var selectedColor: IconColor?
    
    var body: some View {
        VStack(spacing: 0) {
            title
                .padding(12)
            colorStack
                .padding([.horizontal, .bottom], 12)
        }
        .background(Color(.surfaceBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var title: some View {
        HStack {
            Text(String(localized: "Выберите цвет"))
                .foregroundStyle(.textPrimary)
                .font(.callout)
            Spacer()
        }
    }
    
    private var colorStack: some View {
        HStack(spacing: 16) {
            ForEach(IconColor.allCases) { color in
                ColorSelectorCellView(
                    color: color.color,
                    isSelected: selectedColor == color
                )
                .onTapGesture {
                    selectedColor = color
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var color: IconColor?
    
    ColorSelectorView(selectedColor: $color)
        .padding()
        .background(Color(.yellow))
}
