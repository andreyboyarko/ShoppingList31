//
//  ListCell.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/8/26.
//
import SwiftUI
import SwiftData

struct ListCell: View {
    
    let listItem: ListItem
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(listItem.color.color)
                Image(listItem.icon.icon)
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
    }
}

#Preview {
    let item = ListItem(
        color: .blue,
        icon: .calendarNumber,
        title: "Новый год",
        completed: 10,
        total: 20
    )
    
    ListCell(listItem: item)
        .padding(.top, 10)
        .background(Color(.yellow))
}

#Preview {
    let items = [
        ListItem(
            color: IconColor.blue,
            icon: Icon.calendarNumber,
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: IconColor.green,
            icon: Icon.paw,
            title: "Кошке",
            completed: 1,
            total: 4
        ),
        ListItem(
            color: IconColor.yellow,
            icon: Icon.gameController,
            title: "Вечеринка малого",
            completed: 9,
            total: 20
        )
    ]
    
    ForEach(items, id: \.id) { item in
        ListCell(listItem: item)
    }
}
