//
//  ListEditorView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 12.01.2026.
//

import SwiftUI

struct ListEditorView: View {
    
    enum Mode {
        case create
        case edit(ListItem)
        
        var navigationTitle: String {
            switch self {
            case .create: "Создать список"
            case .edit:   "Редактировать список"
            }
        }
        
        var buttonTitle: String {
            switch self {
            case .create: "Создать"
            case .edit:   "Сохранить"
            }
        }
    }
    
    let mode: Mode
    
    @State private var name: String = ""
    @State private var selectedColor: IconColor?
    @State private var selectedIcon: Icon?
    
    @Environment(\.dismiss) private var dismiss
    
    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        selectedColor != nil &&
        selectedIcon != nil
    }
    
    init(mode: Mode) {
        self.mode = mode
        
        switch mode {
        case .create:
            _name = State(initialValue: "")
            _selectedColor = State(initialValue: nil)
            _selectedIcon = State(initialValue: nil)
            
        case .edit(let item):
            _name = State(initialValue: item.title)
            _selectedColor = State(initialValue: item.color)
            _selectedIcon = State(initialValue: item.icon)
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            textField
            colorSelector
            iconSelector
            Spacer()
            button
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                        Text(mode.navigationTitle)
                    }
                    .foregroundStyle(.textPrimary)
                    .font(.headline)
                }
            }
        }
    }
    
    private var textField: some View {
        NameTextField(placeholder: "Введите название списка", text: $name)
    }
    
    private var colorSelector: some View {
        ColorSelectorView(selectedColor: $selectedColor)
    }
    
    private var iconSelector: some View {
        IconSelectorView(
            color: selectedColor?.color ?? .turquoise,
            selectedIcon: $selectedIcon)
    }
    
    private var button: some View {
        ActionButton(
            title: mode.buttonTitle,
            isActive: isValid,
            action: {
                switch mode {
                case .create:
                    createList()
                case .edit(let item):
                    saveList(item)
                }
            }
        )
    }
    
    private func createList() {
        print("List created: \(name), \(selectedColor?.id ?? ""), \(selectedIcon?.id ?? "")")
    }
    
    private func saveList(_ item: ListItem) {
        print("List edited: \(item.id), new name: \(name)")
    }
}

#Preview("Создать список") {
    NavigationStack {
        ListEditorView(mode: .create)
            .appBackground()
    }
}

#Preview("Редактировать список") {
    NavigationStack {
        ListEditorView(mode: .edit(ListItem.mock))
            .appBackground()
    }
}

#Preview("Создать список без NavigationStack") {
    ListEditorView(mode: .create)
        .appBackground()
}
