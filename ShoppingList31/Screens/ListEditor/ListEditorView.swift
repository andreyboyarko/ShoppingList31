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
        case edit(id: ListItem.ID)
        
        var navigationTitle: String {
            switch self {
            case .create: String(localized: "Создать список")
            case .edit:   String(localized: "Редактировать список")
            }
        }
        
        var buttonTitle: String {
            switch self {
            case .create: String(localized: "Создать")
            case .edit:   String(localized: "Сохранить")
            }
        }
    }
    
    let mode: Mode
    
    @State private var name: String = ""
    @State private var selectedColor: IconColor?
    @State private var selectedIcon: Icon?
    
    @Environment(Router.self) private var router
    
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
            
        case .edit(let id):
            let item = ListItem.mockArray.first { $0.id == id }
            ?? ListItem.mockArray.first!
            _name = State(initialValue: item.title)
            _selectedColor = State(initialValue: item.color)
            _selectedIcon = State(initialValue: item.icon)
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                formStack
                    .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
            .scrollDismissesKeyboard(.interactively)
            
            button
        }
        .backButtonWith(title: mode.navigationTitle) {
            router.pop()
        }
    }
    
    private var formStack: some View {
        VStack(spacing: 24) {
            textField
            colorSelector
            iconSelector
        }
    }
    
    private var textField: some View {
        NameTextField(placeholder: String(localized: "Введите название списка"), text: $name)
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
                case .edit(let id):
                    saveList(id)
                }
            }
        )
    }
    
    private func createList() {
        print("List created: \(name), \(selectedColor?.id ?? ""), \(selectedIcon?.id ?? "")")
        router.pop()
    }
    
    private func saveList(_ id: UUID) {
        print("List edited: \(id), new name: \(name)")
        router.pop()
    }
}

#Preview("Создать список") {
    NavigationStack {
        ListEditorView(mode: .create)
            .appBackground()
            .environment(Router())
    }
}

#Preview("Редактировать список") {
    NavigationStack {
        ListEditorView(mode: .edit(id: ListItem.mock.id))
            .appBackground()
            .environment(Router())
    }
}

#Preview("Создать список без NavigationStack") {
    ListEditorView(mode: .create)
        .appBackground()
        .environment(Router())
}
