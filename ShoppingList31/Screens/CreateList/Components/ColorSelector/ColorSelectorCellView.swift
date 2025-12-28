//
//  ColorSelectorCellView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 28.12.2025.
//

import SwiftUI

struct ColorSelectorCellView: View {
    
    let color: Color
    let size: CGFloat
    let isSelected: Bool
    
    init(color: Color, size: CGFloat = 40, isSelected: Bool = false) {
        self.color = color
        self.size = size
        self.isSelected = isSelected
    }
    
    var body: some View {
        ZStack {
            clearCircleWithBorder
            colorCircle
        }
    }
    
    private var clearCircleWithBorder: some View {
        Circle()
            .fill(.clear)
            .stroke(.turquoise, lineWidth: 2)
            .frame(width: size + 5, height: size + 5)
            .opacity(isSelected ? 1 : 0)
    }
    
    private var colorCircle: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
    }
}

#Preview {
    VStack {
        ColorSelectorCellView(color: .red, size: 250, isSelected: true)
            .padding()
        ColorSelectorCellView(color: .red, size: 100)
            .padding()
        Spacer()
        
    }
}
