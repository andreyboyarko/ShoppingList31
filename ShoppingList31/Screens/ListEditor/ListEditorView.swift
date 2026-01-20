//
//  ListEditorView.swift
//  ShoppingList31
//
//  Created by Bogdan Kalitenko on 12.01.2026.
//

import SwiftUI
import SwiftData

struct ListEditorView: View {
    
    enum Mode {
        case create
        case edit(id: ListItem.ID)
        
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
    
    @Environment(\.modelContext) private var context
    @Environment(Router.self) private var router
    
    @Query private var items: [ListItem]
    
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
            _name = State(initialValue: "")
            _selectedColor = State(initialValue: nil)
            _selectedIcon = State(initialValue: nil)
            
            _items = Query(filter: #Predicate<ListItem> { $0.id == id })
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
        onChange(of: items) { _, newItems in
            guard
                case .edit = mode,
                let item = newItems.first
            else { return }

            name = item.title
            selectedColor = item.color
            selectedIcon = item.icon
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
                case .edit:
                    saveList()
                }
            }
        )
    }
    
    private func createList() {
        guard let selectedColor, let selectedIcon else { return }
        
        let item = ListItem(
            color: selectedColor,
            icon: selectedIcon,
            title: name,
            completed: 0,
            total: 0
        )
        context.insert(item)
        router.pop()
    }
    
    private func saveList() {
        guard let item = items.first else { return }
        item.title = name
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
    let item = ListItem(
        color: .blue,
        icon: .calendarNumber,
        title: "Новый год",
        completed: 10,
        total: 20
    )
    
    NavigationStack {
        ListEditorView(mode: .edit(id: item.id))
            .appBackground()
            .environment(Router())
    }
}

#Preview("Создать список без NavigationStack") {
    ListEditorView(mode: .create)
        .appBackground()
        .environment(Router())
}
