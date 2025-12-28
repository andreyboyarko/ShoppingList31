//
//  ColorSelectorView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 28.12.2025.
//

import SwiftUI

struct ColorSelectorView: View {
    
    private let colors: [Color] = [.iconGreen, .iconPurple, .iconBlue, .iconRed, .iconYellow]
    @State private var selectedIndex: Int?
    let onSelected: ((Color) -> Void)?
    
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
            ForEach(colors.indices, id: \.self) { index in
                ColorSelectorCellView(
                    color: colors[index],
                    isSelected: selectedIndex == index
                )
                .onTapGesture {
                    selectedIndex = index
                    onSelected?(colors[index])
                }
            }
        }
    }
}

#Preview {
    ColorSelectorView {
        print("Selected color: \($0)")
    }
    .padding()
    .background(Color(.yellow))
}
