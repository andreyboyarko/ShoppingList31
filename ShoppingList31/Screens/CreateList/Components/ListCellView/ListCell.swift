//
//  ListCell.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/8/26.
//
import SwiftUI

struct ListCell: View {
    
    let listItem: ListItem
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(Color(listItem.color))
                Image(listItem.icon)
                    .foregroundColor(.black)
            }
            .padding(.leading, 16)
            .padding(.vertical, 18)
            
            Text(listItem.title)
                .font(.smallTitle)
                .padding(.leading, 12)
            Spacer()
            
            HStack(spacing: 0) {
                Text("\(listItem.completed)/")
                    .font(.body)
                Text("\(listItem.total)")
                    .font(.headline)
            }
            .padding(.trailing, 16)
        }
        .frame(height: 84)
        .background(.surfaceBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }
}

#Preview {
    ListCell(listItem: ListItem.mock)
        .padding(.top, 10)
        .background(Color(.yellow))
}

#Preview {
    ForEach(ListItem.mockArray, id: \.id) { item in
        ListCell(listItem: item)
    }
}
