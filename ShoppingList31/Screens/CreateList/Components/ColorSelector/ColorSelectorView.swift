//
//  ColorSelectorView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 28.12.2025.
//

import SwiftUI

struct ColorSelectorView: View {
    
    @State private var selectedColor: IconColor?
    let onSelected: ((IconColor) -> Void)?
    
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
            Text("Выберите цвет")
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
                    onSelected?(color)
                }
            }
        }
    }
}

#Preview {
    ColorSelectorView {
        print("Selected color: \($0.id)")
    }
    .padding()
    .background(Color(.yellow))
}
