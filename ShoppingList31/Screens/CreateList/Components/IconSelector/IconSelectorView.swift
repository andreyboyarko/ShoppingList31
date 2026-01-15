//
//  IconSelectorView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 06.01.2026.
//

import SwiftUI

struct IconSelectorView: View {
    
    let color: Color
    @State private var selectedIcon: Icon?
    let onSelected: ((Icon) -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            title
                .padding(12)
            iconGrid
                .padding([.horizontal, .bottom], 12)
        }
        .background(Color(.surfaceBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var title: some View {
        HStack {
            Text("Выберите дизайн")
                .foregroundStyle(.textPrimary)
                .font(.callout)
            Spacer()
        }
    }
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 6
    )
    
    private var iconGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Icon.allCases) { icon in
                IconSelectorCellView(
                    color: color,
                    icon: Image(icon.icon),
                    isSelected: selectedIcon == icon
                )
                .onTapGesture {
                    selectedIcon = icon
                    onSelected?(icon)
                }
            }
        }
    }
}

#Preview {
    IconSelectorView(color: .green) {
        print("Selected icon: \($0.id)")
    }
    .padding()
    .background(.yellow)
}
