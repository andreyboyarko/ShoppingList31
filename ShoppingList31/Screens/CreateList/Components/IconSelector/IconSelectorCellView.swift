//
//  IconSelectorCellView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 06.01.2026.
//

import SwiftUI

struct IconSelectorCellView: View {
    
    let color: Color
    let icon: Image
    let size: CGFloat
    let isSelected: Bool
    
    init(color: Color, icon: Image, size: CGFloat = 48, isSelected: Bool = false) {
        self.color = color
        self.icon = icon
        self.size = size
        self.isSelected = isSelected
    }
    
    var body: some View {
        ZStack {
            circle
            iconOutline
        }
    }
    
    private var circle: some View {
        Circle()
            .fill(isSelected ? color : .iconBackground)
            .frame(width: size, height: size)
    }
    
    private var iconOutline: some View {
        icon
            .foregroundStyle(isSelected ? .iconForegroundSelected : .iconForegroundDefault)
            .font(.system(size: size * 0.45))
    }
}

#Preview {
    VStack {
        IconSelectorCellView(color: .red, icon: Image(systemName: "checkmark"), size: 250, isSelected: true)
            .padding()
        IconSelectorCellView(color: .red, icon: Image(systemName: "checkmark"), size: 250)
            .padding()
    }
    .padding()
    .background(.surfaceBackground)
}
